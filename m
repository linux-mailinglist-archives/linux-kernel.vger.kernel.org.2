Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7258331BAC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhBOOJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhBOOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:09:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF1EC061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 06:08:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m1so9479079wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 06:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRUgaztnseyRZiDI5bhu+FazgsD1lPoDG1QvgTFS76A=;
        b=Sdn4MTwud2ap10fuQ9kEh8fXQffC1u+DZL9c9NJrzwxrv38KNu7LcAZ3DC1FAIIEgn
         D6qVih+4PMf8Zb8DJtevJMkUVsZ7DXljXrld0Kuug2ayyxmnRaSQQ43pd1KhkV4jzP1a
         nohje2x+MWdKmuxb2DIw0z2SOVVKzXfrRjOzb7FSkTEPsNYwXXGrDFTbvaPrfrj8UxPK
         h2oNpd/06/Sc0NlWFjlPrh8b2ovNSI8r0+cVI0KxgAZBNNgCvD/vRo3Pb1PndnBv8In3
         LeVm1eHDgmdwH9mOWmJpI+yXeyJN9zkziDKy6aeOMa9WeK+jfL6fYaw4D6ym/uBHKwOQ
         R8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRUgaztnseyRZiDI5bhu+FazgsD1lPoDG1QvgTFS76A=;
        b=B178r3ovOkqPRDdlVnp4Qecyi32IQpFSfW58vaaG6NfAp2odwrHqHnGSIS2x1dLpFE
         dQP1Gzzrl+TMh/ueG9HTRybNVIXq6xHgzVQ7k0kDxOnx5FyPlzBanyw139p0vwbWX4Mr
         FxbudIcU1VEBWZHScOP3R693/gjJjHK7v3PN4yHYlgmVWdnd27mX26VNN2b6d+D43Smh
         08O23UhjPV8FnKJBRcA0wpBh2EfJiwGXP2pm7dy2ScDlMP4vI+S/umRC4q/jcKp0W+Mo
         q3zfNaAuemHqZn0UYlaTxExPMOllrK56sg2YPJJJXcEHgQb+io1X5Oe17yjs+HZe28u6
         5AQQ==
X-Gm-Message-State: AOAM533+2jED8SQY0hEA3p8amQYOUTHPR/OapWQI5mgGZHnKm7S8kegM
        zfDE9/Ko5JHmg6dsdgZLqf5lfBILZGVZgIRGG7kDPg==
X-Google-Smtp-Source: ABdhPJyp8uaU2W1U0zUYcH8IAjP+t/8mfaC81LqjAAIX6dzQqgJTFOYlkgjuoV+vbhMNt36wHxI7OS/0AUVyweFFtIk=
X-Received: by 2002:a05:600c:4857:: with SMTP id j23mr14592201wmo.31.1613398106389;
 Mon, 15 Feb 2021 06:08:26 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com> <1611737738-1493-5-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1611737738-1493-5-git-send-email-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 15 Feb 2021 14:08:15 +0000
Message-ID: <CAJ9a7VgFbnUVqt5G0oSrfbLBrq9b4iRbvQLpz+v7wiv0NrV9Jg@mail.gmail.com>
Subject: Re: [PATCH V3 04/14] coresight: ete: Add support for ETE sysreg access
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Wed, 27 Jan 2021 at 08:55, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Add support for handling the system registers for Embedded Trace
> Extensions (ETE). ETE shares most of the registers with ETMv4 except
> for some and also adds some new registers. Re-arrange the ETMv4x list
> to share the common definitions and add the ETE sysreg support.
>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 32 +++++++++++++
>  drivers/hwtracing/coresight/coresight-etm4x.h      | 52 ++++++++++++++++++----
>  2 files changed, 75 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 9edf8be..9e92d2a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -114,6 +114,38 @@ void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
>         }
>  }
>
> +u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
> +{
> +       u64 res = 0;
> +
> +       switch (offset) {
> +       ETE_READ_CASES(res)
> +       default :
> +               WARN_ONCE(1, "ete: trying to read unsupported register @%x\n",
> +                        offset);
> +       }
> +
> +       if (!_relaxed)
> +               __iormb(res);   /* Imitate the !relaxed I/O helpers */
> +
> +       return res;
> +}
> +
> +void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
> +{
> +       if (!_relaxed)
> +               __iowmb();      /* Imitate the !relaxed I/O helpers */
> +       if (!_64bit)
> +               val &= GENMASK(31, 0);
> +
> +       switch (offset) {
> +       ETE_WRITE_CASES(val)
> +       default :
> +               WARN_ONCE(1, "ete: trying to write to unsupported register @%x\n",
> +                       offset);
> +       }
> +}
> +
>  static void etm_detect_os_lock(struct etmv4_drvdata *drvdata,
>                                struct csdev_access *csa)
>  {
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 0e86eba..ca24ac5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -29,6 +29,7 @@
>  #define TRCAUXCTLR                     0x018
>  #define TRCEVENTCTL0R                  0x020
>  #define TRCEVENTCTL1R                  0x024
> +#define TRCRSR                         0x028
>  #define TRCSTALLCTLR                   0x02C
>  #define TRCTSCTLR                      0x030
>  #define TRCSYNCPR                      0x034
> @@ -49,6 +50,7 @@
>  #define TRCSEQRSTEVR                   0x118
>  #define TRCSEQSTR                      0x11C
>  #define TRCEXTINSELR                   0x120
> +#define TRCEXTINSELRn(n)               (0x120 + (n * 4)) /* n = 0-3 */
>  #define TRCCNTRLDVRn(n)                        (0x140 + (n * 4)) /* n = 0-3 */
>  #define TRCCNTCTLRn(n)                 (0x150 + (n * 4)) /* n = 0-3 */
>  #define TRCCNTVRn(n)                   (0x160 + (n * 4)) /* n = 0-3 */
> @@ -160,10 +162,22 @@
>  #define CASE_NOP(__unused, x)                                  \
>         case (x):       /* fall through */
>
> +#define ETE_ONLY_SYSREG_LIST(op, val)          \
> +       CASE_##op((val), TRCRSR)                \
> +       CASE_##op((val), TRCEXTINSELRn(1))      \
> +       CASE_##op((val), TRCEXTINSELRn(2))      \
> +       CASE_##op((val), TRCEXTINSELRn(3))
> +
>  /* List of registers accessible via System instructions */
> -#define ETM_SYSREG_LIST(op, val)               \
> -       CASE_##op((val), TRCPRGCTLR)            \
> +#define ETM4x_ONLY_SYSREG_LIST(op, val)                \
>         CASE_##op((val), TRCPROCSELR)           \
> +       CASE_##op((val), TRCVDCTLR)             \
> +       CASE_##op((val), TRCVDSACCTLR)          \
> +       CASE_##op((val), TRCVDARCCTLR)          \
> +       CASE_##op((val), TRCOSLAR)
> +
> +#define ETM_COMMON_SYSREG_LIST(op, val)                \
> +       CASE_##op((val), TRCPRGCTLR)            \
>         CASE_##op((val), TRCSTATR)              \
>         CASE_##op((val), TRCCONFIGR)            \
>         CASE_##op((val), TRCAUXCTLR)            \
> @@ -180,9 +194,6 @@
>         CASE_##op((val), TRCVIIECTLR)           \
>         CASE_##op((val), TRCVISSCTLR)           \
>         CASE_##op((val), TRCVIPCSSCTLR)         \
> -       CASE_##op((val), TRCVDCTLR)             \
> -       CASE_##op((val), TRCVDSACCTLR)          \
> -       CASE_##op((val), TRCVDARCCTLR)          \
>         CASE_##op((val), TRCSEQEVRn(0))         \
>         CASE_##op((val), TRCSEQEVRn(1))         \
>         CASE_##op((val), TRCSEQEVRn(2))         \
> @@ -277,7 +288,6 @@
>         CASE_##op((val), TRCSSPCICRn(5))        \
>         CASE_##op((val), TRCSSPCICRn(6))        \
>         CASE_##op((val), TRCSSPCICRn(7))        \
> -       CASE_##op((val), TRCOSLAR)              \
>         CASE_##op((val), TRCOSLSR)              \
>         CASE_##op((val), TRCACVRn(0))           \
>         CASE_##op((val), TRCACVRn(1))           \
> @@ -369,12 +379,36 @@
>         CASE_##op((val), TRCPIDR2)              \
>         CASE_##op((val), TRCPIDR3)
>
> -#define ETM4x_READ_SYSREG_CASES(res)   ETM_SYSREG_LIST(READ, (res))
> -#define ETM4x_WRITE_SYSREG_CASES(val)  ETM_SYSREG_LIST(WRITE, (val))
> +#define ETM4x_READ_SYSREG_CASES(res)           \
> +       ETM_COMMON_SYSREG_LIST(READ, (res))     \
> +       ETM4x_ONLY_SYSREG_LIST(READ, (res))
> +
> +#define ETM4x_WRITE_SYSREG_CASES(val)          \
> +       ETM_COMMON_SYSREG_LIST(WRITE, (val))    \
> +       ETM4x_ONLY_SYSREG_LIST(WRITE, (val))
> +
> +#define ETM_COMMON_SYSREG_LIST_CASES           \
> +       ETM_COMMON_SYSREG_LIST(NOP, __unused)
> +
> +#define ETM4x_SYSREG_LIST_CASES                        \
> +       ETM_COMMON_SYSREG_LIST_CASES            \
> +       ETM4x_ONLY_SYSREG_LIST(NOP, __unused)
>
> -#define ETM4x_SYSREG_LIST_CASES                ETM_SYSREG_LIST(NOP, __unused)
>  #define ETM4x_MMAP_LIST_CASES          ETM_MMAP_LIST(NOP, __unused)
>
> +/* ETE only supports system register access */
> +#define ETE_READ_CASES(res)                    \
> +       ETM_COMMON_SYSREG_LIST(READ, (res))     \
> +       ETE_ONLY_SYSREG_LIST(READ, (res))
> +
> +#define ETE_WRITE_CASES(val)                   \
> +       ETM_COMMON_SYSREG_LIST(WRITE, (val))    \
> +       ETE_ONLY_SYSREG_LIST(WRITE, (val))
> +
> +#define ETE_ONLY_SYSREG_LIST_CASES             \
> +       ETM_COMMON_SYSREG_LIST_CASES            \
> +       ETE_ONLY_SYSREG_LIST(NOP, __unused)
> +
>  #define read_etm4x_sysreg_offset(offset, _64bit)                               \
>         ({                                                                      \
>                 u64 __val;                                                      \
> --
> 2.7.4
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
