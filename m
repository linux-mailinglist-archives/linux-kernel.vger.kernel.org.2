Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFAD343D20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhCVJl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:41:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:42084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhCVJlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:41:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616406082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0o7kBCMkU5y+xIR5RoOnpWNd7+Am5+l0wjAnUoNjTQ=;
        b=ZTMs1hN7vlfzkhJM6HwH5r9KXxBhrhNdqBjYOzGX28ZJJ+etzyjbE3toO9iQ2Ifj1mrGVh
        mhbosBaLAHHmPHSzDju35EtDZ+8byM24JBC0J17r05X8/yosZ+i8+ZDFlDCxA0O+r369rE
        SoruA5kKBTPRPQ+rOHTipO97ZYdp9+A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11E8CAD6D;
        Mon, 22 Mar 2021 09:41:22 +0000 (UTC)
Message-ID: <4e433b4166dca8dfe9011addcfc5ae0cbc38f90a.camel@suse.com>
Subject: Re: [PATCH 5/7] USB: cdc-acm: clean up probe error labels
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Mar 2021 10:41:18 +0100
In-Reply-To: <20210318155202.22230-6-johan@kernel.org>
References: <20210318155202.22230-1-johan@kernel.org>
         <20210318155202.22230-6-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 18.03.2021, 16:52 +0100 schrieb Johan Hovold:
> Name the probe error labels after what they do rather than using
> sequence numbers which is harder to review and maintain (e.g. may
> require renaming unrelated labels when a label is added or removed).
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>

