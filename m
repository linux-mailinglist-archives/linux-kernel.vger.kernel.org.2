Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A1634C10E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhC2BXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:23:35 -0400
Received: from sonic311-25.consmr.mail.gq1.yahoo.com ([98.137.65.206]:38918
        "EHLO sonic311-25.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230432AbhC2BXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1616981001; bh=eqjbd9XPVN9T1S8YUn7KgLJFn/FuoUGCgnWER5Xp9f8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=OIM0FmFbM+R94h80IpfXSigrDJCkpgr3bzNavWhp9vWHo1IvCs4Yap22Z99apBnJr1dp9FwnwUOzNvFEME+OdezhrwrQacCAVIRSFCJghfZRvl+m8hnsy4DtMfo4o4tQKrEJ2kweDQejX1lQphJfvx7AQFPOXXiLrmBTleRhWcgb+WFVu4RtHn5qhuVXrA/VEU1pG/evev59w+nKGEb/yHRR6oYBUPr12w7YalOoY0eGspjBeulNU9jmO2F7jLfunGG+krCczaDUvF6y3B9WKogu8E7jIn1Iujkpgcy0kei/TX7aFv6JtJjbVMzGIN3NDpLj0bu3iXt6ahYCmmLE5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1616981001; bh=FleFYLBVxh+knR0Xrnpl+o2628vwHspYRAYB9/hA3gI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hHuBcsURN0XDJLApm7KfqA6ioVUQFo7N/Dh7pRupl6mzQVHs2MWpJgq18mQVPN+/BCXVSJiGQyoCfG8nGfPmFRQ2wJDOelTvTUT9OGJiX3X+Z9BZ9S0b18yvuenn5QThWBe+3nqxpEVjhQsKXyO3GmAHboo2gYLcXbDBcl4RGKaha1UQ9K3XWVSMNo0p14MoCTOHxfK1yjnIPniYK9MvQvSgyb9VtmKBOxSivvsC70Z+4+0e96iRrnbKUHeXmWk57sWbXrCpkffH4ZdTOZyNsE6bo4RBLuTzKBicuXeQTyhevGk/TIftMjUlg4sIISQvrewWA1YHI+W6qeVWNf2qXA==
X-YMail-OSG: 30bfElMVM1nPtLbpxwA6z1HfY061Fy2tXgB3M0I.lKaOt7kk3FfJ.UzTKN8GhSu
 nqtWsa.MgfwUWrqd5LvRiQgmht1qTdF5tFa9Yyca8Yv08E_2vWi8snFGqVGeF6OU3WNXoWTW.7XO
 aQwkCn82viWu5FsXLrtBjTZzxSrl04eN9_5u9Mbxwkp2bvdjnf9VhQ6emZlrUDNLLujt9qqqWxND
 MyaFiBvmJb4XdfBeOB_Yk_ygsYkfSE61aWzsWO7PBQ.C8MXBevjRsGKoKmXRbvYDMPRoeHAZS2v2
 6PFr_PdVHg9ZGxfYcyEO8KLz9wDY4dEek.driTLer2Yi58MT45NeLcEX3wuSYppCL7k1i_dTi2kC
 ZKVCtkFlyVsf13_CXRWXLUaIwZrl_whEJO9VhANtvH3CmURo67OBuz8myeuWcMuebkfo_KTihF24
 R6RbVeddxT3D.FtquatMaCJzsJ2.UBKp3gj9AFx1U2ZPTNysgplTAFJgBGBfDZekzUSrcWEXjlzu
 m8nwSuJ0CCp1_R9TPCcchAGW03dZ0g.G99uk3HnLdrfcMz9NCuWwb439PoNqkF.nAds4EAeOzpCU
 JkCajsNQJcTlhWUf5zPCLiOCBNWfVnBZNBsu6WNnZnVYn5PaXe9EpTC7RCVi8ifQb2pOTnsNG3cu
 bJysS_YPoPtKr_AhqhL7aEAQPpXI55vgSZKCfnxpNGPZ.SONYWF.zvo1IiVt4eeF0CyNh56kw99c
 jzWBGWhKwzfwSwS4IXbZHFlB7OaOQI05VoJb8JvkEDUVU3RU.qDsOKp2UozNS3k7yLdlN_g1wKj2
 UCFpho5VbpQLx0FMKO3ouBmnYihDFG8ddEp5X5gaL1znytgAWwsw5J1eAL7PRhJ5tFlT0l5gI6xL
 KnMO9eprhlNXKIlzc0Ge3dUAJcPVf2RHKcdiFkH0R9zgPmg5pcoe1UFJNYmd.07cAQthnI2v6myx
 YNRmT_r19o5fIp8neMgjuXmnHvl.YvUkZeP7Q3MotoJxdn_.f.B2V3qkfjeo5BC7brHTSQ4cEvsv
 hA_7N6IESKhTo66yIKnzG3s54CIlECXVVldbpaomS_eGE6qqS0x0Kz2IcfeDESdd9Lc74cETIPTE
 u1OtC87.dwYrPb.qPbMJ9iTeoTj3SHjDQzkPNTIrElsEsws_zhbsSOVj0.G8jRBgeMTEjNv0bJQs
 e1.BmSskvBx9nBtHTaQOxDnf.EsWSLLrFnYn4wiO8ypndCEbyyezjprAawqtrmGPvp6OKuQkPAZZ
 oa91aGlxdBi8Yo_7yY85NyEzrvHrYY434E1udnryUzeamwm2BXCPGyALPsfp1fnecaB.REszoHux
 v5S9qWKoepAr0yTg6sMpW.yTiJcVEhbQ6KiYpTOBiiugTQvz3vFghnUHWLMy4TDiesRJtdJo0Q81
 tShEJZ5BQiK.05eF3lDZmaozXqjBX0zauuW55vpQUTM6LXL2uxox88aZG269_VmRXoHRbuT0XjPs
 zhcn2IhnTXLFdQGZc0TJSXNMfm7Lz_rY7rHv0CO2MXJctvqEHrpserS9p66fSHTm7MSQ8T_HoIG2
 x9OqO19D7IAEP_35K2FBelLbo8k_R2lE1CtkIx3i62dLdqy91zSGN.ZABYbjzZx6QEP0AzyILrqs
 t04MF2rZSf3M90As82JbYn8nGMLLRLcSyr80dCf1mYLzdovQEREZ5TWn2QrsH.qVwfYETx7aQqQI
 PaVH8XeWaw.blA06MJKah_us0KE1b8h662JgTIlAnLiQ0QbmEWy9fULPbZMSqxm87EiYTBsAAgbr
 UtVhUrq5B64QtPx47d.ZpWYjf7oJhsfJCbjYVzYetINqD2jUDqhfHdRGWZlgPDd4Vv3xG9o77nCB
 J.zWoSdYelBFPNA5lS0RrO4iXJbnmhRs8ChGu4CON_ZJ7NhUU9LkGtmQXuqjOgT6_jVOWZdPjA8_
 yEqsSB5eNUHPxwPy8Og.fDNFKXi.w10eIz6OLPwcD_Mw5wC2TSZfdHbllRiqjbB5N2Coa6MU4SIV
 WhMufeudIhtnBjAMhdk8TtP2_KNyQWvG2_ilIegc9AvrlVGOjqWa1m4CRuCvXob1VsyTWcHru2oW
 Hcal30gDPHyVktjmKb8fl_xRAJ3gjG9lfHpFn_7Pu6fWeYziwniAUXRhDWoill0pYfW0C6pSGRuf
 aI82sE5CQOGvRVa5cuQwH00e0U87T3DvtsrPVmAfzPycXTZnBipLIqkSV19O84luuYwn34AqWEOF
 FEclDOC5MjskWowXV0MSO5yad7F4LgYCcPRZaUBAz1PHiyffaQsrHfjxixqbN10Nca5e7tFh5npF
 GEETp9eVahK9J46NUy3OSpcMgWUF6aHLcbyS.JFJQqBjEfDSIhwZyAqe8sxqrZVxVM1mFfg89xgj
 LpYVV7YurvBUhNg.HCEzZKQDCkim2rdkTi3MpwghPsdR9sKhA4KOYdGn_puGOI8S4rBJ4CKmp61_
 PZQIoQXUX8py6N.dnffznd2Cik17Lr0Zbje3yjG1DhSMizcraVGsOsf5QVWeduQpV9OzAM9DJHQS
 QaNpiXnRDFlicPwV.k71yq46EMroVtEwmlffCdfO6v.CMjh06CxWp6HVX7UjEG45tK1UUs9i20ih
 2i3jrJ6qtTc4uDyZj7L2mSnoUQ1t3IVW0ay9J35Mnefu.rA--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 29 Mar 2021 01:23:21 +0000
Received: by kubenode575.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3d9d64f8790c67205a0f6cb47abdabe6;
          Mon, 29 Mar 2021 01:23:17 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2 0/4] erofs: introduce on-disk compression configurations
Date:   Mon, 29 Mar 2021 09:23:04 +0800
Message-Id: <20210329012308.28743-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210329012308.28743-1-hsiangkao.ref@aol.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

Hi folks,

When we provides support for different algorithms or big pcluster, it'd
be necessary to record some configuration in the per-fs basis.

For example, when big pcluster feature for lz4 is enabled, we need to
know the largest pclustersize in the whole fs instance to adjust per-CPU
buffers in advance, which will be used to handle in-place decompression
failure for inplace IO then. And we also need to record global arguments
(e.g. dict_size) for the upcoming LZMA algorithm support.

Therefore, this patchset introduces a new INCOMPAT feature called
COMPR_CFGS, which provides an available algorithm bitmap in the sb
and a variable array list to store corresponding arguments for each
available algorithms.

Since such a INCOMPAT sb feature will be introduced, it'd be better to
reuse such bit for BIGPCLUSTER feature as well since BIGPCLUSTER feature
depends on COMPR_CFGS and will be released together with COMPR_CFGS.

If COMPR_CFGS is disabled, the field of available algorithm bitmap would
become a lz4_max_distance (which is now reserved as 0), and max_distance
can be safely ignored for old kernels since 64k lz4 dictionary is always
enough even new images could reduce the sliding window.

Thanks,
Gao Xiang

Changes since v1:
 - [2/4] add a comment on lz4_max_distance (Chao);
 - [4/4] fix a misplaced label (Chao);
 - [4/4] enable COMPR_CFGS with BIG_PCLUSTER later since they share
         the same bit.

Gao Xiang (3):
  erofs: introduce erofs_sb_has_xxx() helpers
  erofs: introduce on-disk lz4 fs configurations
  erofs: add on-disk compression configurations

Huang Jianan (1):
  erofs: support adjust lz4 history window size

 fs/erofs/decompressor.c |  35 ++++++++--
 fs/erofs/erofs_fs.h     |  20 +++++-
 fs/erofs/internal.h     |  33 +++++++++
 fs/erofs/super.c        | 147 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 224 insertions(+), 11 deletions(-)

-- 
2.20.1

