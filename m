Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8C73EEDC5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbhHQNx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbhHQNx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:53:57 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5187EC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 06:53:24 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id f6so13202226vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfkQkjNGfGQdOuT8yQjkAj91Udyc0OGvi85Mwof3PH8=;
        b=Rt73VYuiw1sz1tSfHMM6rzDZwwR/oSiveWrnrisBHqK6IGEOUOUlRyEZqHVx3N3TNb
         UFHWWu5VgVqERhOFFWZSf9SD9v+5L1BwTbL5TwSO6cX9UC+sh28Zq3j2+KH8yrUW+Rld
         olD+hRhXdDRI14iPUMys2gVTsVqmlK4ZZILGx5ULDClxEPXl2F3jX7ZQRFJGkoqwC9/c
         CIXUs9ZTNVdVo9xe9+t7Zumy1xrDjaUnf4mgvUvVlLSPoniX14q1+A1eL2WXXQiK7oPs
         GgOmjSVM7pLkZwJ3ewBFkB/l4suC6ND8Jpc7HuRf9kKXMCYa5e1vQc+tS7xJScrLXJ8b
         wUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfkQkjNGfGQdOuT8yQjkAj91Udyc0OGvi85Mwof3PH8=;
        b=sz0WFGu6VRR5J0lM8e/DC1J9zgTdhMT1UHcEBO3OS2azL4paFa6ako3HszL5EHKOko
         w8PyLmjM/FsJ+mDz6KOWF9wyqy2yzOe4+rUlDUdyxAOXtdcjz6zdj9q/CD52zFQSVayN
         PdYpX5QY8bBrUTl0MbIdiVpNhOeizNR15n+T+vYJI793pd+DMcMoKE/zvI3Go83Hb+cE
         nox1t4zUKvlRnYJ2PQiSQPIGMPmy07N7nJ1z4q2MNByuDXrWyvZzuK4I6yxHEFao+wKe
         dIk2HLMBFJQJbJUpyW5m5AsSSwT9U1rI2FTnnzVlrUfTTLCjZ5NwbW0Y0+4GOBFt60ZV
         UGdw==
X-Gm-Message-State: AOAM531kwB6HEBLqg191kEBhiqKiQHS7oW2MD3p4Kp2AXsb6LmJK//OG
        s31VT05LWK/lH4FGPqYgZ7cfTJzX+Bx6hz75r4qh5A==
X-Google-Smtp-Source: ABdhPJxJmYW88Ev1ks/v9+BGAp05ASceu2cDL3gJmffO4wJWaGzGP8q2pDY2O4Csdw373h0sW7M8fDiO3qm0JSuaM2k=
X-Received: by 2002:a67:bb15:: with SMTP id m21mr2888819vsn.26.1629208403329;
 Tue, 17 Aug 2021 06:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com> <20210809152448.1810400-5-qperret@google.com>
In-Reply-To: <20210809152448.1810400-5-qperret@google.com>
From:   Andrew Walbran <qwandor@google.com>
Date:   Tue, 17 Aug 2021 14:53:11 +0100
Message-ID: <CA+_y_2EsStP+zNOfykjrmJBx6a1pxaewC2X9TnXnj3kNpixsWg@mail.gmail.com>
Subject: Re: [PATCH v4 04/21] KVM: arm64: Introduce helper to retrieve a PTE
 and its level
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        alexandru.elisei@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org,
        Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002a307905c9c1a4d2"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002a307905c9c1a4d2
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Aug 2021 at 16:25, Quentin Perret <qperret@google.com> wrote:
>
> From: Marc Zyngier <maz@kernel.org>
>
> It is becoming a common need to fetch the PTE for a given address
> together with its level. Add such a helper.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 19 ++++++++++++++
>  arch/arm64/kvm/hyp/pgtable.c         | 39 ++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index f004c0115d89..082b9d65f40b 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -432,6 +432,25 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size);
>  int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
>                      struct kvm_pgtable_walker *walker);
>
> +/**
> + * kvm_pgtable_get_leaf() - Walk a page-table and retrieve the leaf entry
> + *                         with its level.
> + * @pgt:       Page-table structure initialised by kvm_pgtable_*_init().
> + * @addr:      Input address for the start of the walk.
> + * @ptep:      Pointer to storage for the retrieved PTE.
> + * @level:     Pointer to storage for the level of the retrieved PTE.
> + *
> + * The offset of @addr within a page is ignored.
> + *
> + * The walker will walk the page-table entries corresponding to the input
> + * address specified, retrieving the leaf corresponding to this address.
> + * Invalid entries are treated as leaf entries.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
> +                        kvm_pte_t *ptep, u32 *level);
> +
>  /**
>   * kvm_pgtable_stage2_find_range() - Find a range of Intermediate Physical
>   *                                  Addresses with compatible permission
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 05321f4165e3..78f36bd5df6c 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -326,6 +326,45 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
>         return _kvm_pgtable_walk(&walk_data);
>  }
>
> +struct leaf_walk_data {
> +       kvm_pte_t       pte;
> +       u32             level;
> +};
> +
> +static int leaf_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> +                      enum kvm_pgtable_walk_flags flag, void * const arg)
> +{
> +       struct leaf_walk_data *data = arg;
> +
> +       data->pte   = *ptep;
> +       data->level = level;
> +
> +       return 0;
> +}
> +
> +int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
> +                        kvm_pte_t *ptep, u32 *level)
> +{
> +       struct leaf_walk_data data;
> +       struct kvm_pgtable_walker walker = {
> +               .cb     = leaf_walker,
> +               .flags  = KVM_PGTABLE_WALK_LEAF,
> +               .arg    = &data,
> +       };
> +       int ret;
> +
> +       ret = kvm_pgtable_walk(pgt, ALIGN_DOWN(addr, PAGE_SIZE),
> +                              PAGE_SIZE, &walker);
> +       if (!ret) {
> +               if (ptep)
> +                       *ptep  = data.pte;
> +               if (level)
> +                       *level = data.level;
> +       }
> +
> +       return ret;
> +}
> +
>  struct hyp_map_data {
>         u64                             phys;
>         kvm_pte_t                       attr;
> --
> 2.32.0.605.g8dce9f2422-goog
>

Reviewed-by: Andrew Walbran <qwandor@google.com>

--0000000000002a307905c9c1a4d2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmgYJKoZIhvcNAQcCoIIPizCCD4cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz0MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
NLKLRXC2UkITUqkLDDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMIGaBggrBgEFBQcB
AQSBjTCBijA+BggrBgEFBQcwAYYyaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vY2EvZ3NhdGxh
c3Izc21pbWVjYTIwMjAwSAYIKwYBBQUHMAKGPGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20v
Y2FjZXJ0L2dzYXRsYXNyM3NtaW1lY2EyMDIwLmNydDAfBgNVHSMEGDAWgBR8zApo16LrHixyG9HN
XZVvjfvyYzBGBgNVHR8EPzA9MDugOaA3hjVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dz
YXRsYXNyM3NtaW1lY2EyMDIwLmNybDANBgkqhkiG9w0BAQsFAAOCAQEAJZz81Ay9V97/pdWQKMlY
/Qku3gwyyzEfaZz7QTjClOWkncwBR4WF63koFYe6vpd9RBX1upBOk5vhr9n6mXjmLxLfxWqU/xsq
sIJJDk19oBSQvbt138wyZBe6UYYgQhQ3ZvU/9vTXB9geysqPfJbr27MYJ0ZFrCDlQdW49MksZ1x6
6lozqMEFN/tTBhma7G7hGCHF/4rP3XXH/o4f5ftfL23dA+4F9sPwugH2sjEt7Dn/7eCFhT4Hbf7/
P/Sxi49Xlra8e/bCTotvMPt76LN69+0lcZzcc/oNJJttsCLBqBZ7ABTSiTQaLp4UwTgTYMg7eBqD
oJF2uULm2EfP8cT7HzGCAmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
bFNpZ24gbnYtc2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMAIQ
AdV711V3BM5Q4YSSMDl1STANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgRSTyEkut
N4kTEeAqJ8YqqIMxFBiaIpIxisez+VBDwXUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjEwODE3MTM1MzIzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHuYbpEtRWazYW0f6ODhCeBBRHjC
ZMA9Tbk/qqN6dDGEatfOhKgSCBNk8cm2UnN1Aavmb6HIWHmHOD4sSAoI5I2x/MebusI3QS+8xmjC
EROIrToBqqsr6gZ6s/WQagEx0jmzQdr0eTUYzfSxCTtQSVkk5Gcwig1NDZ02fPXOnaLsBCjmHo8Z
d8lc6kvFL4NtvurqGU+Q5cPlbDdiNSTfnHb+fKu5AsxsoLncItIycQ4fR4D6FUvEggCU6saW24Nk
VmO1DlZODrN6OzLsEVVlHSnbA2f5nNz5LAGxbHVy5qTVRwy4IC3IEiWc60PJXnj+ztmwmACYAOIe
LrwAbJ4Droo=
--0000000000002a307905c9c1a4d2--
