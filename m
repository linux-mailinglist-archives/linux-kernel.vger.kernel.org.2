Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7204844F7B4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 12:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhKNL7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 06:59:34 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:58739 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhKNL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 06:59:25 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3EECE320090C;
        Sun, 14 Nov 2021 06:56:31 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Sun, 14 Nov 2021 06:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=jbtmMvfNuo7PAXY0xC9HrkPpy8Iq
        5wRtAW7Ssk3ma54=; b=f3lTks4mrCRA58cVD2+6xf0ZuYOLFRQpJBg+vPCtFLkQ
        iCm6pvqvX9MVq4dMC0iGYuN4bHhn6qnfXSYMOf+PHr7kZ7uWLsYjjXa3f4YVFqjJ
        KsI2EJvkmuLnrCdeWl7S2QPZSKJm1cgSfqE72oYfwCMMa/QwokpBKl2DkBL7p7J5
        /nPESb9J6VltbH/v00it3sAjv29WlDp1CzFhRIq/KGMxe45jGpc5wKC4cVVwyYrk
        bRtkFXBYjb/QA6MFO5k9Ncc2+T3W2DpuiWkaNXIEP3tG/eXdTXajZIFZWNjZ0Icp
        0NF7HMZzjwYvPBvo3Lyl49Z1u7OSBrt1QP/YCREWcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jbtmMv
        fNuo7PAXY0xC9HrkPpy8Iq5wRtAW7Ssk3ma54=; b=OxQWFs8wcmtXO3zlo8TY9F
        VibpMDEMEEFqc45fDV683BUjgHLWjNNpMsJZyGQd4hCZ7NUCsETlTnDC0I+jPEAF
        hXzKKwdY1XUVamm8tgFqnSfrPIfCBixyxVfdFaykefTvNSaqvAa8rOZjw5O549vA
        ooDq679uvTaAtbL/H/8uRShq3pxbBbfcASjoiYJO3lLDm+3Fwa4dSL9SDA0cb1PH
        DADz5gH1i8sKzE/GQh21efgZLT7VtEp8tdvHdyaLgiyEhqSSSQW3cIUZ2lum4UDs
        oM/oYrgMxkU3dWElLhv+21kwCNoIo1Q8Xtr72HuOucyFEc8wxuAM8pNVSPXcr5cA
        ==
X-ME-Sender: <xms:bvmQYcZi9yCm4yuXSadABvHqQsz_oucQpX6EKV09Qv2svqf3HUakSg>
    <xme:bvmQYXYOkVbpG-h2nkCr6_fN2uYYCHSlp0b4_PKZ62HtaUOdk4-gU8vmj840d-Joi
    F76xcLrgYOaR2K2XrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdejgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:bvmQYW-E6c59FvoRDnajP5WRRkli3odGIJ60-MsQk-S9cTIEw0bulw>
    <xmx:bvmQYWqJoIMD-UXMF6-chz9YPASAwn1V7TUo5VdynpNXeUisZhk6Uw>
    <xmx:bvmQYXqCyxzIx2DC9qLDo-QrUmgTPMPcJKCXOZzK-iMEWB7R6Dkddg>
    <xmx:bvmQYYDeJ9oA6ywmorzQ0gNO-4zggLgyapulW3PoZQ3KJksY5yerAg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6A45E274013E; Sun, 14 Nov 2021 06:56:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <34347fd8-1d67-4d16-b09f-061bc0c0cb5a@www.fastmail.com>
In-Reply-To: <20211113142959.27191-1-fabioaiuto83@gmail.com>
References: <20211113142959.27191-1-fabioaiuto83@gmail.com>
Date:   Sun, 14 Nov 2021 12:56:02 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Fabio Aiuto" <fabioaiuto83@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Felipe Balbi" <balbi@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        "hch@lst.de" <hch@lst.de>, hdegoede@redhat.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: leave default DMA for PCI devices
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021, at 15:29, Fabio Aiuto wrote:
> in case of a PCI dwc3 controller, leave the default DMA
> mask. Calling of a 64 bit DMA mask breaks the driver on
> cherrytrail based tablets like Cyberbook T116.
>
> Fixes: 45d39448b4d0 ("usb: dwc3: support 64 bit DMA in platform driver")
> Reported-by: Hans De Goede <hdegoede@redhat.com>
> Tested-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/usb/dwc3/core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 643239d7d370..f4c09951b517 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1594,9 +1594,11 @@ static int dwc3_probe(struct platform_device *pdev)
> 
>  	dwc3_get_properties(dwc);
> 
> -	ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
> -	if (ret)
> -		return ret;
> +	if (!dwc->sysdev_is_parent) {


Are you sure it's the dwc3 controller that limits DMA to 32 bit addresses and
not the PCI bus itself?
I also think the xhci driver will call dma_set_mask_and_coherent again
later on when dwc3 is used in host mode.



Sven
