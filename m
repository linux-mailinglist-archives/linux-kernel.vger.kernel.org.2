Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F42437AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhJVQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 12:34:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:54271 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233286AbhJVQel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:34:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="229607478"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="229607478"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 09:32:23 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="534986075"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 09:32:23 -0700
Date:   Fri, 22 Oct 2021 09:40:11 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 2/5] staging: vt6655: Rename
 `byInitCount` variable
Message-ID: <20211022164011.GB464908@alison-desk>
References: <cover.1634826774.git.karolinadrobnik@gmail.com>
 <53430b1183324f6a715999792a15df2ea6a3e206.1634826774.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53430b1183324f6a715999792a15df2ea6a3e206.1634826774.git.karolinadrobnik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:37:15AM +0100, Karolina Drobnik wrote:
> Drop Hungarian notation in `byInitCount` variable in
> `RFvWriteWakeProgSyn` function. Change it to use snake case.
> 
> Fix issue detected by checkpatch.pl:
>   CHECK: Avoid CamelCase: <byInitCount>

Hi Karolina,

This comment is for all the patches.

Commit msg:
We've got plenty of space on that line, how about:
"Rename byInitCount init_count"

(I say this because when someone searches by the oneliners it's
nice to give as many keywords as possible - within the line limit)


Commit log:
The log (why this patch is important) seems to be saying that
snake case is the fix for Hungarian notation. I don't think that
is completely true. Snake case avoids the camel case of Hungarian
notation, but we are also dropping the type descriptor which is
another signature of Hungarian notation.

Perhaps this would be more direct:

To align with the kernel coding style, remove the type from
the variable name and do not use CamelCase.

Reported by checkpatch.pl:
	CHECK: Avoid CamelCase: <byInitCount>

(Not for the log, but a ref if you don't have:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html)

Alison

> 
> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> ---
>  drivers/staging/vt6655/rf.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> index 7e441309dd9c..36708af7d612 100644
> --- a/drivers/staging/vt6655/rf.c
> +++ b/drivers/staging/vt6655/rf.c
> @@ -681,7 +681,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
>  {
>  	void __iomem *iobase = priv->port_offset;
>  	int i;
> -	unsigned char byInitCount = 0;
> +	unsigned char init_count = 0;
>  	unsigned char bySleepCount = 0;
>  
>  	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
> @@ -693,9 +693,9 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
>  			return false;
>  
>  		 /* Init Reg + Channel Reg (2) */
> -		byInitCount = CB_AL2230_INIT_SEQ + 2;
> +		init_count = CB_AL2230_INIT_SEQ + 2;
>  		bySleepCount = 0;
> -		if (byInitCount > (MISCFIFO_SYNDATASIZE - bySleepCount))
> +		if (init_count > (MISCFIFO_SYNDATASIZE - bySleepCount))
>  			return false;
>  
>  		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
> @@ -709,9 +709,9 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
>  		/* Need to check, PLLON need to be low for channel setting */
>  	case RF_AIROHA7230:
>  		 /* Init Reg + Channel Reg (3) */
> -		byInitCount = CB_AL7230_INIT_SEQ + 3;
> +		init_count = CB_AL7230_INIT_SEQ + 3;
>  		bySleepCount = 0;
> -		if (byInitCount > (MISCFIFO_SYNDATASIZE - bySleepCount))
> +		if (init_count > (MISCFIFO_SYNDATASIZE - bySleepCount))
>  			return false;
>  
>  		if (uChannel <= CB_MAX_CHANNEL_24G) {
> @@ -736,7 +736,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
>  		return false;
>  	}
>  
> -	MACvSetMISCFifo(priv, MISCFIFO_SYNINFO_IDX, (unsigned long)MAKEWORD(bySleepCount, byInitCount));
> +	MACvSetMISCFifo(priv, MISCFIFO_SYNINFO_IDX, (unsigned long)MAKEWORD(bySleepCount, init_count));
>  
>  	return true;
>  }
> -- 
> 2.30.2
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/53430b1183324f6a715999792a15df2ea6a3e206.1634826774.git.karolinadrobnik%40gmail.com.
