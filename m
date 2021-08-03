Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5045B3DE424
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 03:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhHCBuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 21:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233208AbhHCBuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 21:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627955426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdR8zfCNf4wv+ttRPaVnBXWWBuoumvByTOHRL/URBMA=;
        b=WPMe3vAGvF/Fmn7PSIAaZzHxyjh0SSggbiZCDn44qrbCVlAnuHyuvWCLrbfPlFkFtIipFx
        cKhe9kuOqKIDi0EtJYZzjj/hhraPTB20I8bwMlu/C4frht+wjDPgeO0WtjXyIB1JMNQ4XN
        Cn/KdKCbztsGBUCoqlO2qJM6gJLc+mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-K9jVr-LgNA6m-JJPto0HLw-1; Mon, 02 Aug 2021 21:50:24 -0400
X-MC-Unique: K9jVr-LgNA6m-JJPto0HLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94867DF8A3;
        Tue,  3 Aug 2021 01:50:23 +0000 (UTC)
Received: from suzdal.zaitcev.lan (ovpn-112-59.phx2.redhat.com [10.3.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3829260BD9;
        Tue,  3 Aug 2021 01:50:23 +0000 (UTC)
Date:   Mon, 2 Aug 2021 20:50:22 -0500
From:   Pete Zaitcev <zaitcev@redhat.com>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        zaitcev@redhat.com
Subject: Re: [PATCH] usb: class: usblp: replace conditional statement with
 min()
Message-ID: <20210802205022.357279fc@suzdal.zaitcev.lan>
In-Reply-To: <20210803002806.GA1541734@pc>
References: <20210803002806.GA1541734@pc>
Organization: Red Hat, Inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 01:28:06 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> Replace conditional statement with min() in order to make code cleaner. Issue
> found by coccinelle.

> +++ b/drivers/usb/class/usblp.c
>  		request, !!dir, recip, value, index, len, retval);
> -	return retval < 0 ? retval : 0;
> +	return min(retval, 0);
>  }

I'm very much against this change. The function min() is there
for numeric values. But here we have a situation where we
do one thing if there was an error, and another thing if
there was no error.

This sort of abuse is exactly why blindly clicking heels
whenever a tool tells you is not optimal.

If the objective is to shut the tool up, please consider
the following instead:

diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index 9596e4279294..bbcbcf199fa9 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -264,7 +264,9 @@ static int usblp_ctrl_msg(struct usblp *usblp, int request, int type, int dir, i
        dev_dbg(&usblp->intf->dev,
                "usblp_control_msg: rq: 0x%02x dir: %d recip: %d value: %d idx: %d len: %#x result: %d\n",
                request, !!dir, recip, value, index, len, retval);
-       return retval < 0 ? retval : 0;
+       if (retval < 0)
+               return retval;
+       return 0;
 }
 
 #define usblp_read_status(usblp, status)\


-- Pete

