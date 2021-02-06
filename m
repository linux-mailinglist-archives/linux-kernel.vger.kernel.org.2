Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610BD311CEC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 12:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhBFLiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 06:38:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:44837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhBFLiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 06:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612611390;
        bh=1gDMzBOXApT4dZra9NexIlsNZan3JK+JlZ5frPub26g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VI/wp6yRSpIKh1M3XxuXpeaC1ZpgFy7/NsKNcWJyyIheL9BITBY7gH1GKlsIypmnm
         oHjftHSh57LF4cTPBQSBDdbjKcfPsChmLQmmn14DtToxG8sso/+62lNN2cUDgPSE7l
         e3GUcCiel/nWhrnhliO0YqZ4LmPgNxs64B9LGnh4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.167] ([37.4.249.89]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMbU-1lBazy0ywu-00EOo2; Sat, 06
 Feb 2021 12:36:30 +0100
Subject: Re: [RFC/PATCH 02/11] dt-bindings: soc: bcm: brcm,bcm2835-pm: Add
 support for bcm2711
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     phil@raspberrypi.com, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210205135249.2924-1-nsaenzjulienne@suse.de>
 <20210205135249.2924-3-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <aedc0d72-b160-b35c-edbc-c43bae031741@gmx.net>
Date:   Sat, 6 Feb 2021 12:36:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205135249.2924-3-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:9qigCL0cfYF91zWWGv7/lqP1/oIk1oJiUZBcRqIH42DxLCSLkAr
 zuPHtZFyGOQolHyr/RQb63dtu+5ovaAeajp9HzWc8Qa8Yo/GXssjLUlUtHYC7QB51mOaSZW
 e2QsMfWeJXVUGZ/gYMSdn3yQ34PWE7IzI1/rsvBYXm8Cg3uxhmTa6HdJYeREA2RR+lrmyhk
 PXMdekmnQInGyNPP/2PAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yog0IGFOYZg=:kqvaJBzS0BOB0kGmg+rs+d
 tw8nzKfeRj3SyLxOtqTefPEgx0kAR5dKLSex+YV7eiYvr1Q1Fsq0j+OPncQicQljBb8ajhKMA
 k6XoXnmrjy7yJ6hvHtHlS/kSVGaTHLckWKt6lApIy/MN2GdbP47/R9SUJBOZuADbxhhDEGdlk
 qpRyazf5rE93Uiba8d053OKolqo794SaWB++8NReETm3IA/riu93leXnkODQ3OkT5UqhHrN62
 z2YBZTACTdTsmuM1NHd/C+esk01K9iDO6SajzeAbxSBYIG84w5Z6VBH06LA3D8k+3oS1oiLk0
 IKGA2WJkD39VWI0N3mo/s2gEy4D2yinNfXvvSDnXFaLIP6k5ZPTUnymCAun9xe43kQa5M5dkI
 qSyJkU9Rdcn3H4phBBQlURtsxVV4jeE3WAz/s5i1fwZsAB4TBp+WB/fANPknCj5+GRyxasVOY
 NWtgfeKjgcHmZvd/5/t5OZKWYtvW6gsBP6CO3YWOJEbMK7KAxLTtoAMppxwPJvfqFb8cPlBIi
 A8UFjQcfAK/jZvjwq0JiHurdBeidu6rc/pDLEm+npsMpEGuaoOSWhcs+GvL/DTg6NblVXGbJU
 PoDr7AnPzqp66L22LS0mAG0ymKv16nDH6EiPeMXRcpVzc/WcrdimwQ+8ehPvsFsZjNc66RcM4
 ZLXSbrhNwHdhgMgjqBV62LYfMZMkgdCI/aDfAXJ45glt6IwLs+7GJRLetodJYKlBgfU60uQuX
 luCQubo5YLnGs79xBuPyr+DQOoDNJrpMzmpmI0UPCThmZOoeySB2KCRYJ9wYw3Wpnivb9EjSI
 47vzKLOjuH2CQ2Z9hgnMUNRfEIp99dpcZQ2FJ19aej40Jtx8syUBqNcoI4YTwaTn+b2kfyUL/
 UsJDdafCWxLQbqZoaSNw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 05.02.21 um 14:52 schrieb Nicolas Saenz Julienne:
> Add a new compatible string for bcm2711 and the option to provide a
> third reg property for the board's new Argon ASB.
>
> The new Argon ASB took over V3D, which is our only consumer of this
> driver so far. The old ASB is still be present with ISP and H264 bits
> but no V3D.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml       | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.y=
aml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> index 5e0555fc0666..a1f2e25e68db 100644
> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> @@ -21,13 +21,14 @@ properties:
>      items:
>        - enum:
>            - brcm,bcm2835-pm
> +          - brcm,bcm2711-pm
>        - const: brcm,bcm2835-pm-wdt
>
>    reg:
>      minItems: 1
> -    maxItems: 2
> -    description: Specifies base physical address and size of the two re=
gister
> -                 ranges, "PM" and "ASYNC_BRIDGE" in that order.
> +    maxItems: 3
> +    description: Specifies base physical address and size of the regist=
er
> +                 ranges, "PM", "ASYNC_BRIDGE" and "ARGON_BRIDGE" in tha=
t order.
i know it's not trivial, but maybe we have reached the point to
introduce reg-names here.
>
>    "#power-domain-cells":
>      const: 1
