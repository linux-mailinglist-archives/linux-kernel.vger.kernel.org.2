Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54B940DED9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 18:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbhIPQAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 12:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240403AbhIPQAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:00:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EA856124D;
        Thu, 16 Sep 2021 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631807964;
        bh=GaCTzSIAgugH052OtJe3MAsmhy3oRXntm2uoObsHuj4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O+8/2cDx2xu3lNUzz6omHISDHdjoc/4/7bnauMmWxidgOsjIYSDzMMvJJR7Iy2GEw
         1VymODcs7VCF2IckRzuZoXW/5whog+h02cjjrPj8LLMfnOMhwrxAT0Zm5Y255jj2a5
         NCJXMu3nX/TGfN8DvRxbxNhbjIusVOy+fuBFhFVeUlryClIvqk+nVLJfGZTub6S3Yn
         fEm+E1VAEE7WI5uFCX9uokpqR/zl99RpjmLOoQImXntZpctVNXeS1azyHS5Rsl/uyF
         ypT/yUJkQAVx27PlA22uAfRUf/JhPFLba3eqo48Crb2Jd/I+B0SlgzFazTclNHmxgX
         ntYVIgLG9Pjlg==
Message-ID: <26ba3d661d0c8a9e4a44be908dfc7cd2d89a2d43.camel@kernel.org>
Subject: Re: [PATCH v3 05/30] ABI: sysfs-class-tpm: use wildcards for pcr-*
 nodes
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org
Date:   Thu, 16 Sep 2021 18:59:22 +0300
In-Reply-To: <4ab3fce91ea2bd7c36a07e6c646bf7bd6f4f8634.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
         <4ab3fce91ea2bd7c36a07e6c646bf7bd6f4f8634.1631782432.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-16 at 10:59 +0200, Mauro Carvalho Chehab wrote:
> Change how this expression is defined:
>=20
> 	/sys/class/tpm/tpmX/pcr-H/N
>=20
> in order to allow get_abi.pl to convert it into this regex:
>=20
> 	/sys/class/tpm/tpmX/pcr-.*/.*
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/ABI/stable/sysfs-class-tpm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI=
/stable/sysfs-class-tpm
> index d897ecb9615f..411d5895bed4 100644
> --- a/Documentation/ABI/stable/sysfs-class-tpm
> +++ b/Documentation/ABI/stable/sysfs-class-tpm
> @@ -195,7 +195,7 @@ Description:	The "tpm_version_major" property shows t=
he TCG spec major version
> =20
>  		  2
> =20
> -What:		/sys/class/tpm/tpmX/pcr-H/N
> +What:		/sys/class/tpm/tpmX/pcr-<H>/<N>
>  Date:		March 2021
>  KernelVersion:	5.12
>  Contact:	linux-integrity@vger.kernel.org


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

