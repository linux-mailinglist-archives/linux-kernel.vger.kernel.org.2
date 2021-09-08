Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1597B404056
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 22:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352015AbhIHUyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 16:54:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:39899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235437AbhIHUy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 16:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631134383;
        bh=gGyssjxabohIjDxtvSkR6S2G+R/GgD+Ug3BlWj57mTc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dKSxVQGr07tIiKKuYkeXWuzl2m58yq5rK/mQgVxPpQdZSlMAj8Fz9oDyFBc4vWEFM
         knRlLZiz322q2yvQF1WWQ3AFQ5eGw4VO8kZ2EaXi6lXaGXhD//5oV5NK+kSg5zvRSR
         FX1cY78/HoHb9/tdqjdZHpCy9ZRvSTbvcof4ZiU4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.85.61] ([80.187.121.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mulm5-1nFLhs0hff-00rm9Y; Wed, 08
 Sep 2021 22:53:03 +0200
Subject: Re: [PATCH] parisc: Move pci_dev_is_behind_card_dino to where it is
 used
To:     Guenter Roeck <linux@roeck-us.net>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210908153041.643069-1-linux@roeck-us.net>
From:   Helge Deller <deller@gmx.de>
Message-ID: <8392d93e-73d8-0a9e-15e2-db139086fdf0@gmx.de>
Date:   Wed, 8 Sep 2021 22:51:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908153041.643069-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nRdMm2osOOu780aITU30zP7UhFvqrvZ4Jxcf6m9DZMSQ+ySiG4R
 2DG0uW6rccx/EyMiAz/ykE/kNd133z2Hkg3g26znlPbgzOVJMrSS3VkP+g97uTa3yaQ60zF
 hKVaMdNbRlZVQErBVp4wGGzNWogTS2cLt4fKBnIJ32MOO+OyXnl3wSjOvLNdogUqpX9XDJQ
 7Emd7jkM+XEydhYTyeI6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sxTCNEFc818=:rm7ecPnH9AuqDOoYbOHT8a
 MIKB2Hc0oEnZiDF3Fztn6/xGkaV+DwcDylgtiQBs8FzsjKioNogDJyd6xGcgTYzH/pyo9FENz
 bx8YjeQBxRXvzKj0f44Za8bXeC7vD8abFfsWQuJdU++2aiGTRvLOfLduG6wkRRgcbtRSIZpEt
 CoGrfHGmC7XSZ4MgCM300deuvnl0Ae/PzrAzsn83Y2J53t15mhZBX+9ur++GoAvh1YrNUzWXR
 c99xyvHnTxgClndLsmeb/x/RTzXcRpoh0nT4Phrt2Uq+dbeRT3M3H/7Xxg0HcQCU731OWHDhM
 GcjBJs57nz/+7vVE5zXultcSwX1jzN5uHaVRliOWq8jGHYxAGrRPYMS415vzXpHfWjtg7PDlL
 xu8i53ifid7QGKbHFezCsA0uOyvOTbmam5kM4Mg2yQ3aczfBRXL4IXQ8TZf1gGWsLbyG92K3q
 BuIvWCh8vNCbgExD02zDT1P3mziRYTo63EJ8XhKOOeE82CibBFOCqgdKywm3QE61bXKKit3bL
 yz8hjYEXzlXLm6bH7TGC1KqGN48sQKlHSf4WyQFdG+ofr7bhtovNc8tr59EvzrYjug7pc6+EJ
 +uYqjlcexttmnbOxAtJxBmL1VTbQCCsHUCXZU+uCNpSxYJ5txmosqgGElH7HSS/a4+6Z6WEfN
 6PW7dtLT+jDg1tYFkchLM52mOhbjZS+oMLcce798Nd55HvPESLkfrEHqJKvsPZ+1b7b0yxn9r
 yOY0dRjbF7rkrShJxFyfCJGrMgdxRyciKYyzzPYwB30XBA+tk8mks26j51kg6w7T1zVLQZ+tK
 qv5Dea2eEcj/LA5LgNDezxMPOw/fy5LkxcOzP2U37XJTL6BK4gYA7JI00yGT0adE8q84pG+ad
 ByXc7lEm0hXys/qCyUdQkYT/nzriFF5O/PZE44e6fW0YpfEoX5uNudyWBma5zFyGLVkNE2Nl/
 nOiLMUC7Wlezg0qkv9bWWOG85K0+XBMGiZNbezpLkuSg1VQ0fZdDdnkSp/5BMJxnkZMMYIHAT
 DaodUmv6V2ZLRp27VIo9mVQdZopWwr+XSQFIQ55a8pmcgOBPNlvwI9vYyBodDdvgql1bpNLiB
 oj9vBOm/Jy3cik=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 5:30 PM, Guenter Roeck wrote:
> parisc build test images fail to compile with the following error.
>
> drivers/parisc/dino.c:160:12: error:
> 	'pci_dev_is_behind_card_dino' defined but not used
>
> Move the function just ahead of its only caller to avoid the error.
>
> Fixes: 5fa1659105fa ("parisc: Disable HP HSC-PCI Cards to prevent kernel=
 crash")
> Cc: Helge Deller <deller@gmx.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

applied to the parisc tree.

Thanks!
Helge


> ---
>   drivers/parisc/dino.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
> index 889d7ce282eb..952a92504df6 100644
> --- a/drivers/parisc/dino.c
> +++ b/drivers/parisc/dino.c
> @@ -156,15 +156,6 @@ static inline struct dino_device *DINO_DEV(struct p=
ci_hba_data *hba)
>   	return container_of(hba, struct dino_device, hba);
>   }
>
> -/* Check if PCI device is behind a Card-mode Dino. */
> -static int pci_dev_is_behind_card_dino(struct pci_dev *dev)
> -{
> -	struct dino_device *dino_dev;
> -
> -	dino_dev =3D DINO_DEV(parisc_walk_tree(dev->bus->bridge));
> -	return is_card_dino(&dino_dev->hba.dev->id);
> -}
> -
>   /*
>    * Dino Configuration Space Accessor Functions
>    */
> @@ -447,6 +438,15 @@ static void quirk_cirrus_cardbus(struct pci_dev *de=
v)
>   DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_68=
32, quirk_cirrus_cardbus );
>
>   #ifdef CONFIG_TULIP
> +/* Check if PCI device is behind a Card-mode Dino. */
> +static int pci_dev_is_behind_card_dino(struct pci_dev *dev)
> +{
> +	struct dino_device *dino_dev;
> +
> +	dino_dev =3D DINO_DEV(parisc_walk_tree(dev->bus->bridge));
> +	return is_card_dino(&dino_dev->hba.dev->id);
> +}
> +
>   static void pci_fixup_tulip(struct pci_dev *dev)
>   {
>   	if (!pci_dev_is_behind_card_dino(dev))
>

