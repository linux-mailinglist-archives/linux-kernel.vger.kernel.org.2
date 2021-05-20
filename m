Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2456B38AF96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbhETNFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:05:48 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53529 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240983AbhETNFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:05:39 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id DD6631725;
        Thu, 20 May 2021 09:04:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 20 May 2021 09:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=PB8aFO0bwnqJ+dOxGGLQidZNKsJ
        Ew8NFmWMUOhVb3Gw=; b=OA+mtaUyy+VSofW6UXYNgJ5/3R4srrqaaqkKXww4Alc
        NKTVGGuPpuYpZqm6UuN5FY8VTazomSef4/sMYD0S2fm/2tN/tfGsx0Vs3LrRvELa
        9hXlzbpRPf0XlXQ6/8uHICfTzKEsdVITZJIdpNzr5GSwVKobspUzB3Aj/RmT2Mbm
        q2sHztRaHLCc0zT0o/Q2sFFWWVfrKkvRcDAzlK/F8kIvH4LFePld1lDGFSdPZSJl
        9aIyXzNovmB3wEjmqNEvP97lvbzF79fDh3lIar9ViE0k83MFxz28KhY4ijnHexyL
        cTf4XPJxlfBW6F4v8DIIWbArpHs1JHgc4JU8mhBjDnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=PB8aFO
        0bwnqJ+dOxGGLQidZNKsJEw8NFmWMUOhVb3Gw=; b=lwe9suLQ3B4Osp9BqL76mh
        87GaL31cD2UGzZwhCOL3F9SqgSmMgs46u952/zry+PNR2XSWz6wVxO7lTkIndhOK
        NPl8zWyu0SEpKW24l804/ENaKVvchUQPkCOZYlu/E0Cbua/1+/Av+Pp0GDVUE8zr
        jrMkM8kcAW57uFgCHwPzf9N0hKat9uszngOEVlCHYiL6oH3kt+ILRGvxYOljN7n1
        rBm0xf+msiZTfngT9PKVxKRDTSeI2nqb9U9jpns2Hc2bdAFdaUP/7AMbH8mx04fg
        rQJ4jUd7VeWXMSxyEBuYyzjQmrPpMVXcgnlI3sb2h+JtAHmnw/DypngXtTwIEycw
        ==
X-ME-Sender: <xms:Tl6mYPhfJFavWrDCnzg7x82gmC5te8x9hqOJE3t5eca2f225llJa5A>
    <xme:Tl6mYMDISyzs4y3E5j03ECTQMfZWj5KDGTU34thAjHb9ht0FYJQs3CC6YaQjYaTy6
    sLJAdE_dcow2VV_jiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejuddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
    tddtgeetjeekvdefgeefhfenucfkphepudegrdefrdeihedrudejheenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehs
    rghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Tl6mYPFRAXuQ36b-S0BeEy738PjkkgVYK3B8s5CD-M75UJsYcFQ9WA>
    <xmx:Tl6mYMTVPVxQVUXot91qZmpBO3NM1iaaft7fDdjiaEKm_uItZNh1aw>
    <xmx:Tl6mYMzgVRncpkMZm1dIgltnU0HN-DofwMXrk0kKNYYA12GsytY4ng>
    <xmx:UF6mYLqb_IHyEpP-gtHzTeuOjQv3YLbjch_vjUOcEtfolyiO-TgCnA>
Received: from workstation (ae065175.dynamic.ppp.asahi-net.or.jp [14.3.65.175])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 20 May 2021 09:04:12 -0400 (EDT)
Date:   Thu, 20 May 2021 22:04:09 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Colin King <colin.king@canonical.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: firewire-lib: Fix uninitialized variable err
 issue
Message-ID: <20210520130409.GA170303@workstation>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
        Colin King <colin.king@canonical.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210520083424.6685-1-colin.king@canonical.com>
 <s5hh7ixh9qn.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hh7ixh9qn.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 20, 2021 at 02:26:24PM +0200, Takashi Iwai wrote:
> On Thu, 20 May 2021 10:34:24 +0200,
> Colin King wrote:
> > 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently in the case where the payload_length is less than the
> > cip_header_size the error return variable err is not being set
> > and function parse_ir_ctx_header can return an uninitialized
> > error return value. Fix this by setting err to zero.
> > 
> > Addresses-Coverity: ("Uninitialized scalar variable")
> > Fixes: c09010eeb373 ("ALSA: firewire-lib: handle the case that empty isochronous packet payload for CIP")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Just a bikeshed, IMO, it'd be more proper to initialize err at the
> beginning than setting 0 at every branch, e.g.
> 
> --- a/sound/firewire/amdtp-stream.c
> +++ b/sound/firewire/amdtp-stream.c
> @@ -652,7 +652,7 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
>  	unsigned int payload_length;
>  	const __be32 *cip_header;
>  	unsigned int cip_header_size;
> -	int err;
> +	int err = 0;
>  
>  	payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
>  
> @@ -683,7 +683,6 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
>  		}
>  	} else {
>  		cip_header = NULL;
> -		err = 0;
>  		*data_blocks = payload_length / sizeof(__be32) / s->data_block_quadlets;
>  		*syt = 0;

Thanks for the patches.

The error check is just done for the case to process CIP header, thus we
can put the auto variable into the branch.

======== 8< --------
From 3fcca0062297e937c665f1c8e3a117e1187f4115 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Thu, 20 May 2021 21:59:50 +0900
Subject: [PATCH] ALSA: firewire-lib: Fix uninitialized variable err issue

The check of error is just done for the case that CIP header is available.

This commit moves auto variable into the branch to process CIP header.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: c09010eeb373 ("ALSA: firewire-lib: handle the case that empty isochronous packet payload for CIP")
Suggested-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 37c8de8a..11ae4e88 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -748,7 +748,6 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 	unsigned int payload_length;
 	const __be32 *cip_header;
 	unsigned int cip_header_size;
-	int err;
 
 	payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
 
@@ -766,6 +765,8 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 
 	if (cip_header_size > 0) {
 		if (payload_length >= cip_header_size) {
+			int err;
+
 			cip_header = ctx_header + IR_CTX_HEADER_DEFAULT_QUADLETS;
 			err = check_cip_header(s, cip_header, payload_length - cip_header_size,
 					       data_blocks, data_block_counter, syt);
@@ -779,7 +780,6 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 		}
 	} else {
 		cip_header = NULL;
-		err = 0;
 		*data_blocks = payload_length / sizeof(__be32) / s->data_block_quadlets;
 		*syt = 0;
 
@@ -790,7 +790,7 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 	trace_amdtp_packet(s, cycle, cip_header, payload_length, *data_blocks,
 			   *data_block_counter, packet_index, index);
 
-	return err;
+	return 0;
 }
 
 // In CYCLE_TIMER register of IEEE 1394, 7 bits are used to represent second. On
-- 
2.27.0
======== 8< --------


Thanks

Takashi Sakamoto
