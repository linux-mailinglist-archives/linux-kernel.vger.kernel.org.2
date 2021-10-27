Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D187A43D0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbhJ0SaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:30:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:32939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243557AbhJ0SaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635359263;
        bh=jyO49XaUNGwNU/bzsTT0sBbiyD6kTmH7ETxMu3W7TMA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
        b=AY/YrEAuN2kjH01rL98WOFwacY4QyaZNXKG3eTOUslDku0R1OISF8Zn/RYm77Zxnj
         9K2SoGjDdb0h1mDDcRDDENtwgBRkqShFq0Vmw6SSLXHQWLDfKlfgp/r2PkcpFRdJLG
         GnUpcrIcIBQjEhXzJTUmTZSbAE4aCx4nZCjQif1E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.55] ([88.152.144.157]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1mZAs306X2-006iNR; Wed, 27
 Oct 2021 20:27:43 +0200
Message-ID: <bbc73df5-acda-5577-2cfd-ee8c8e1018c3@gmx.de>
Date:   Wed, 27 Oct 2021 20:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/1] include/linux/byteorder/generic.h: fix index
 variables
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210523204958.64575-1-xypron.glpk@gmx.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20210523204958.64575-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H7FLG6Iucb3oGoFOexKWlu0QfNGwAFKnU37+PrM4ZeHndM9bKS5
 5e/u6FAAafCpr17OepCrexxeHVw5VVmRNwEIVhU28Q8BWTh9jCEx1TFMRiVBWxgS834lLm9
 z1bTtTXzBZbktQPniEtJvpzqctGPmjVnx/aRcoXbTN8KFdYgyIc7PAQB8/ULJA6luOzPz7a
 Cw1DqsFISDJoMmQCNC4NA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:p2gMn2HW7/s=:jxGGkcwx5W08x5hR75yx2w
 GcDWwVPlVvaiTHfqx3jw8xt5jL5qyzEArFkKh1k91vQTuLtOYZVit55mx2Brnkvc1k07aCMVg
 eHX8hNLmePbESjublC+qiWZ3vtd/RcDnTCrYv8fn8GHNFX2DEwukPDhM5+i1NXmUZg72WlxIu
 J5ffJQ/MY6hU9gbmNlf6a3wrJjECaA57pbD4yUaS8naOvMZHrDIJIQxyAN71fLZ1IYaDw6d6L
 6GuL3pEtNm1OdgOoliiNxwXxheWWNg0DOMWeo/cddkjddE6qDuOxZXKy+8xExAXLPE+3pnfFZ
 7U/aeA5UZdiriPszPhc0cQuQstW2fceI2dgvtvte+p1Rfl2gZOTewRFfOcbF552E4jQgknGr2
 lsT2A+eSTq8WczPdqg601V1nCZWwrTByzH/Cr0RFLt48YAv5ppXWa5irHnW6zjmO1XxVFuvQA
 TizVc8nb6TIByF1V/4bOus/Zh1XctAoXR5pQR9Im7vCuwk+uF+PMXzVwr9LLylKvgxk4K9sEX
 zkYhZLb4rTJCNOAUOOlJc/ia4IsKyQAZ4E0ZJucoKWUatRzakvpEy5bBdyUviInBGmNc8QhUs
 WZ5nHLi8Ql/x02PegW4t+PZVv/Vg+ucmr95MuKSGWBoGm5ew35mKAXHYDTb/MPSfAJt4nHSFe
 p9dTwJZ6a+uaCTshfNvF02mB8qJ4eItbwtrJSnryBK8kQt2BoEssHjgGssbA6cBaAXBOqyljS
 xRMuvOovDWR2ttRd6KYyoA9+taQ+0PNoahG3F9+hto5SREbiiDQVxiXAfGOSNMquW1IVZ8V2M
 im+We+XcLGoZ67j38xV6sqroYgnALpbStYbqijoivR11k+YzIT/uHC6tvdgXf7l08LW9cu96T
 gtvru6kmOqg3WurxWhXLFmD1anngJKhx3Sxa4iycNwPSzxcg32C3jI227G164C+zcR27L+6X1
 UEWE3KKAUjAaDmIhfsIplCfss6rf6Is9M6Fm4KTmA4c+n3LSHb4NrPoHn335Lgpu/lzWvxqAw
 TuzzfnS9fAW+LSDi421tf3H+QytviiM9kVVVhoUVLAMny2PvOv0TywtCkFfqcBzSueCgKZLHf
 S96eDJI9CExYlQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/21 22:49, Heinrich Schuchardt wrote:
> In cpu_to_be32_array() and be32_to_cpu_array() the length of the array i=
s
> given by variable len of type size_t. An index variable of type int is u=
sed
> to iterate over the array. This is bound to fail for len > INT_MAX and
> lets GCC add instructions for sign extension.
>
> Correct the type of the index variable.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   include/linux/byteorder/generic.h | 4 ++--

Dear Greg,

This file is not assigned to any maintainer. Could you handle the patch?

Best regards

Heinrich

>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder=
/generic.h
> index 4b13e0a3e15b..c9a4c96c9943 100644
> --- a/include/linux/byteorder/generic.h
> +++ b/include/linux/byteorder/generic.h
> @@ -190,7 +190,7 @@ static inline void be64_add_cpu(__be64 *var, u64 val=
)
>
>   static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size=
_t len)
>   {
> -	int i;
> +	size_t i;
>
>   	for (i =3D 0; i < len; i++)
>   		dst[i] =3D cpu_to_be32(src[i]);
> @@ -198,7 +198,7 @@ static inline void cpu_to_be32_array(__be32 *dst, co=
nst u32 *src, size_t len)
>
>   static inline void be32_to_cpu_array(u32 *dst, const __be32 *src, size=
_t len)
>   {
> -	int i;
> +	size_t i;
>
>   	for (i =3D 0; i < len; i++)
>   		dst[i] =3D be32_to_cpu(src[i]);
> --
> 2.30.2
>
>
