Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D69F457C90
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 09:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbhKTI3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 03:29:43 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57061 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236389AbhKTI3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 03:29:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D1DA5C0174;
        Sat, 20 Nov 2021 03:26:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 20 Nov 2021 03:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yhQdDz8IvFGR0FMCBQ/mJ32u+45
        GUwHq+HUJDX5bVnU=; b=RAejQMGbFod6CKCV/y39nS5BlSwaNtIRXCY5pNzpCH0
        RvqYeDs36w38X3kRuJ33yaP0jbxV9TqlbfYckXORwBmucKv7JWzFJgofkgrI3WrH
        cb15RrISwXPSXlUC+tXh1nFeM3W/TClJEIvXIymZRkbknmEqWCjRR2hxjvVj4JxJ
        dK+/NYNiS+nH8N11LkZ5x9OSNlvM/ggTRfsRWogqpOJJtGHLOG4ESfPg+p0omEiX
        n09SPUTXZ8/3kigii8isRkzvySrtvC1hpgKbvfSC8q8xp1Wuflxc4rulIgiUtUbz
        +wdH6+QYfv8c+VpJ0ivmMH3ku/rdozkf1rgm24GkNcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yhQdDz
        8IvFGR0FMCBQ/mJ32u+45GUwHq+HUJDX5bVnU=; b=m2gAF99pQ+/QSWitX2TuLH
        2ACLzIRHngGyNS4LL6z2HEu13uTZt36NwdBHs2XRyBX8kP8HGqKKynsMv250E6Mm
        4nzN8+isuTsZF9p2m3nvmZvEbQO2JVS1cKnyjkHh8ipxDnkDyEqKMWqPFNUTeZX5
        T4QdRfJf0DsIT9wwyGfSxCHc6dYFpxckzC4J1JVTU8ycPGN2UoA3ICtELXZRApQR
        GHxD/oq4Y2tMFrTLG3dXA4sy///Rp1H7RjZwcQvFPWzUZzxd5ywHRTUQTM3breQ0
        SfU9XBvGMfuiFl96ZZa+hpfIX1ZStKO+FdxfzDep63NbW2Lxa7WhhgtxlqA8P/nA
        ==
X-ME-Sender: <xms:P7GYYbNveEAEf0MTqh-FzHmWx3Qvhmuty24o3a5aGfKvjK9xGNRpQA>
    <xme:P7GYYV99nCLS4jKCdePumrGcjNv4BMcSuAnzxA1vTNs5Wb9E0f-y8kE7wi5U9FjLj
    svvWu-NYpW2Ag>
X-ME-Received: <xmr:P7GYYaQTOUISbBUjRxWlbkp1HYFCOxHUFm16YpE2fw-5U_AYS4LObAR15althW6_En3Ejmm2qLfJwXBzVoGD-3a6FIBXe2TH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeelgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:P7GYYfsgBhIcDQt5mKpI4tHMXqj-RY12xQYRmGUkN0GrhcKbkzcdhw>
    <xmx:P7GYYTdR5Xun9LM8wViekVEwh_r2Vs7j_WQAeoDgN1MhPxE-E01wtw>
    <xmx:P7GYYb2aNdmBqgwmCbhBskX7Wgf9XNd4uyGd1Tbn1jMeAhjNHK9OqA>
    <xmx:P7GYYbQn_bfy1B4Jry9btfMzvYgdiC9GoNOpiHuEhCoeb2VfetaTGA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Nov 2021 03:26:38 -0500 (EST)
Date:   Sat, 20 Nov 2021 09:26:36 +0100
From:   Greg KH <greg@kroah.com>
To:     Zoeb Mithaiwala <zoebm@google.com>
Cc:     trivial@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] Staging: rtl8712: rtl871x_security: fixed a camel case
 variable name coding style issue
Message-ID: <YZixPDg8kKHZrGJB@kroah.com>
References: <20211120080658.1070907-1-zoebm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120080658.1070907-1-zoebm@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 08:06:58AM +0000, Zoeb Mithaiwala wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Zoeb Mithaiwala <zoebm@google.com>
> ---
>  drivers/staging/rtl8712/rtl871x_security.c | 12 ++++++------
>  drivers/staging/rtl8712/rtl871x_security.h |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
> index e0a1c30a8fe6..4b341074b1b2 100644
> --- a/drivers/staging/rtl8712/rtl871x_security.c
> +++ b/drivers/staging/rtl8712/rtl871x_security.c
> @@ -269,7 +269,7 @@ static void secmicclear(struct mic_data *pmicdata)
>  /* Reset the state to the empty message. */
>  	pmicdata->L = pmicdata->K0;
>  	pmicdata->R = pmicdata->K1;
> -	pmicdata->nBytesInM = 0;
> +	pmicdata->nbytes_in_m = 0;
>  	pmicdata->M = 0;
>  }
>  
> @@ -285,10 +285,10 @@ void r8712_secmicsetkey(struct mic_data *pmicdata, u8 *key)
>  static void secmicappendbyte(struct mic_data *pmicdata, u8 b)
>  {
>  	/* Append the byte to our word-sized buffer */
> -	pmicdata->M |= ((u32)b) << (8 * pmicdata->nBytesInM);
> -	pmicdata->nBytesInM++;
> +	pmicdata->M |= ((u32)b) << (8 * pmicdata->n_bytes_in_m);
> +	pmicdata->nbytes_in_m++;
>  	/* Process the word if it is full. */
> -	if (pmicdata->nBytesInM >= 4) {
> +	if (pmicdata->nbytes_in_m >= 4) {
>  		pmicdata->L ^= pmicdata->M;
>  		pmicdata->R ^= ROL32(pmicdata->L, 17);
>  		pmicdata->L += pmicdata->R;
> @@ -301,7 +301,7 @@ static void secmicappendbyte(struct mic_data *pmicdata, u8 b)
>  		pmicdata->L += pmicdata->R;
>  		/* Clear the buffer */
>  		pmicdata->M = 0;
> -		pmicdata->nBytesInM = 0;
> +		pmicdata->nbytes_in_m = 0;
>  	}
>  }
>  
> @@ -323,7 +323,7 @@ void r8712_secgetmic(struct mic_data *pmicdata, u8 *dst)
>  	secmicappendbyte(pmicdata, 0);
>  	secmicappendbyte(pmicdata, 0);
>  	/* and then zeroes until the length is a multiple of 4 */
> -	while (pmicdata->nBytesInM != 0)
> +	while (pmicdata->nbytes_in_m != 0)
>  		secmicappendbyte(pmicdata, 0);
>  	/* The appendByte function has already computed the result. */
>  	secmicputuint32(dst, pmicdata->L);
> diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging/rtl8712/rtl871x_security.h
> index 8461b7f05359..006ce05c798f 100644
> --- a/drivers/staging/rtl8712/rtl871x_security.h
> +++ b/drivers/staging/rtl8712/rtl871x_security.h
> @@ -192,7 +192,7 @@ struct mic_data {
>  	u32  K0, K1;         /* Key */
>  	u32  L, R;           /* Current state */
>  	u32  M;              /* Message accumulator (single word) */
> -	u32  nBytesInM;      /* # bytes in M */
> +	u32  nbytes_in_m;      /* # bytes in M */

The comments are not alined anymore?

And why "n"?


>  };
>  
>  void seccalctkipmic(
> @@ -200,11 +200,11 @@ void seccalctkipmic(
>  	u8  *header,
>  	u8  *data,
>  	u32  data_len,
> -	u8  *Miccode,
> +	u8  *miccode,

This is a different change :(

greg k-h
