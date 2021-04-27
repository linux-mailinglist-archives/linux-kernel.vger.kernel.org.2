Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D857536BEFC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 07:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhD0Fht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 01:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhD0Fho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 01:37:44 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B962EC061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:37:01 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 3so3686636qvp.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/sVwM7mlL1vef64jKYNZVvCyWcLNvFInf/73n/TBts=;
        b=PKaZLvcNX4PV92l/t7cs/baPXjtiubKcLhrEB1/sunq5Z9NjonEB8PugVNlOXKcGm+
         vzAeZFgKDG9zI5Cqy/Ml/t3AkGKXSLDX+rzg57UlFiY1v175qzlDQRasmytW8mnL2gnM
         ajUwOgXxYTJwW3uuQhkRuvfRR9pdObOczzUck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/sVwM7mlL1vef64jKYNZVvCyWcLNvFInf/73n/TBts=;
        b=PXgn0cYPkJz26WQ9Z9mXyoqnWivkJyR2v8ksy+80wgee8bgAR0+k0QD7TNxqBcFnwU
         VxOwdswUidRovONUTNWc0vGbubuiEIKGmNKyw2m/zcTRGZ8v8YinMX1i1jaJkGdTO8Pi
         leeGQFXjpI0l3FbdzbZXSwA/bX3+Xb0EZwPtAZzCiW9Dnu64fBkfpPLH1Mrxeuhx3g43
         j+1jHfwtSz6XKiqRZDZSpLNdrngEzr6sx+vVJZmniUIpTzAMPSVtF6E8ACcJfONmLMTw
         uy/CL8ZpmRuLHkKamB3SlVSWac8rOQTphfgkJ9x+RYumXdAJxYgROBCnQ/phSPbsoPR2
         3uvQ==
X-Gm-Message-State: AOAM530NVjeoI+QSas7XleQ0gTHesv6jgRUrZ7bFi76drDf4sOcjk0bM
        AZZ5r/KrRudQfF3YjxRgD6z4ew5J+I/bXsRgY7ODOg==
X-Google-Smtp-Source: ABdhPJyPq+CxXEJEKWRRUlFjFTiNpahHVs5q+n7DnlnaaBgZzzyMcypXe5v++ODUr/sAZDvlhXQnmvQWs3dRRZEseMY=
X-Received: by 2002:a0c:ef06:: with SMTP id t6mr9732026qvr.17.1619501820512;
 Mon, 26 Apr 2021 22:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210426140614.6722-1-lyl2019@mail.ustc.edu.cn> <YIeYUD5iWv/TI3PH@unreal>
In-Reply-To: <YIeYUD5iWv/TI3PH@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Tue, 27 Apr 2021 11:06:24 +0530
Message-ID: <CANjDDBivHfZheoiiq-WxwAM2MEaeSaF_p2hXA1WR4AqiH32bpg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bnxt_re/qplib_res: Fix a double free in bnxt_qplib_alloc_res
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c4477205c0eda643"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c4477205c0eda643
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 27, 2021 at 10:21 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Apr 26, 2021 at 07:06:14AM -0700, Lv Yunlong wrote:
> > In bnxt_qplib_alloc_res, it calls bnxt_qplib_alloc_dpi_tbl().
> > Inside bnxt_qplib_alloc_dpi_tbl, dpit->dbr_bar_reg_iomem is freed via
> > pci_iounmap() in unmap_io error branch. After the callee returns err code,
> > bnxt_qplib_alloc_res calls bnxt_qplib_free_res()->bnxt_qplib_free_dpi_tbl()
> > in fail branch. Then dpit->dbr_bar_reg_iomem is freed in the second time by
> > pci_iounmap().
> >
> > My patch set dpit->dbr_bar_reg_iomem to NULL after it is freed by pci_iounmap()
> > in the first time, to avoid the double free.
> >
> > Fixes: 1ac5a40479752 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> > Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> > ---
> >  drivers/infiniband/hw/bnxt_re/qplib_res.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-By: Devesh Sharma <devesh.sharma@broadcom.com>


-- 
-Regards
Devesh

--000000000000c4477205c0eda643
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TUsFTOuxP4FZ9JSu9FWkGJGPobx8FmEvg+HybmXuUG0+PU7EDHKNoW8AcgZvIQYbwfevqWBFwwRD
Paihaaj18xGk21lqZcO0BecWKYyV4k9E8poof1dH+GnKqwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEe3qNwswWXCeWt/hTDSC
KajMvUgwDQYJKoZIhvcNAQELBQADggEBAGm+rkHFWdX4Z3YnpNuhM5Sj6w4b4z1pe+LtSquNyt9X
SNuffkoBuPMkEpU3AF9DKJQChG64RAf5UWT/7pOK6lx2kZwhjjXjk9bQVlo6bpojz99/6cqmUyxG
PsH1dIxDlPUxwxCksGuW65DORNZgmD6mIwNhKI4Thtdf5H6zGq2ke0523YysUqecSws1AHeA1B3d
G6Yi9ScSuy1K8yGKKgHn/ZDCLAVEG92Ax5kxUaivh1BLKdo3kZX8Ot/0mmWvFcjEqRyCE5CL9WAo
PU3wdmxYDWOzX5HgFsvArQl4oXob3zKc58TNeGivC9m1KwWJphsMkZNjc2IVVC8gIryWh90xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwhg1OJo0VLRNay
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN97jaN29ALuGPiYfFQI6gjLyXyb
877onUleEliZ8khtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDQyNzA1MzcwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCO/zZiMxXtihrDspYRMRk2Q+nf3FZXdVYpPdgXZlfhXeLR
3EeJpOO5rvXImCgQaynXAzYHo/5kamhGaYSralZYB8dNvjUI2jDWVbcCC+IAMo4CCuZQIIxCchwJ
jb4W3seyixQhmdaAq8lFQRz10a/mVD+aZct8dSWRWWACgVftimnqMTe5JqOvUWNjysYZH0oFSavc
dwMydQhvQuF92f74pk+WwZOnLBjPPCG4vDgK5bJc0aq2qKDcxbZOoF2r0NPHC1VAvDXEaR/E0ULH
cFqjzW2bpjgZFLqLL0mNDmyK0ZlUjN7hRgV2GzkTPWvJ5kSbRKSkiDg5kGvnypUtYx5H
--000000000000c4477205c0eda643--
