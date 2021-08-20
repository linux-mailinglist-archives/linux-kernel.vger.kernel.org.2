Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE9B3F3761
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbhHTXpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 19:45:18 -0400
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:57430 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229529AbhHTXpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:45:17 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A8CFD181B9DC3;
        Fri, 20 Aug 2021 23:44:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id B62101D42F4;
        Fri, 20 Aug 2021 23:44:37 +0000 (UTC)
Message-ID: <56a7a9a9f8d71cb47431ea18c7394cd3d3bdb3e4.camel@perches.com>
Subject: Re: [PATCH] Usb: storage: usb: fixed coding style issues
From:   Joe Perches <joe@perches.com>
To:     Niklas Lantau <niklaslantau@gmail.com>, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Date:   Fri, 20 Aug 2021 16:44:36 -0700
In-Reply-To: <20210820223954.2945-1-niklaslantau@gmail.com>
References: <20210820223954.2945-1-niklaslantau@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.14
X-Stat-Signature: tm41na3m44sha8qygahtu4kod5goqh3x
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: B62101D42F4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX192M261RX/kpJDJeC+wap5OjtUmjrmddBo=
X-HE-Tag: 1629503077-830485
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-08-21 at 00:39 +0200, Niklas Lantau wrote:
> Fixed coding style issues that generated 1 error and 1 warning.

While this hardly needs changing:

> diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
[]
> @@ -295,7 +295,7 @@ void fill_inquiry_response(struct us_data *us, unsigned char *data,
>  }
>  EXPORT_SYMBOL_GPL(fill_inquiry_response);
>  
> 
> -static int usb_stor_control_thread(void * __us)
> +static int usb_stor_control_thread(void *__us)
>  {
>  	struct us_data *us = (struct us_data *)__us;
>  	struct Scsi_Host *host = us_to_host(us);

I'd write this renaming __us to the much more typical data
and remove the useless cast of a void *.
---
 drivers/usb/storage/usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 90aa9c12ffac5..e78e20fb1afa5 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -295,9 +295,9 @@ void fill_inquiry_response(struct us_data *us, unsigned char *data,
 }
 EXPORT_SYMBOL_GPL(fill_inquiry_response);
 
-static int usb_stor_control_thread(void * __us)
+static int usb_stor_control_thread(void *data)
 {
-	struct us_data *us = (struct us_data *)__us;
+	struct us_data *us = data;
 	struct Scsi_Host *host = us_to_host(us);
 	struct scsi_cmnd *srb;
 

