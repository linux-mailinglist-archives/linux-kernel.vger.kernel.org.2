Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB82434B3DA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 03:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhC0Ckx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 22:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhC0Ckg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 22:40:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC09FC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 19:40:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l1so1794577plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=pHLbO4m6UeqPCuuwhwHghQmO8aGMEWbNr+yVqSETj4o=;
        b=KFRXf1IYHppbqXTcy+G6HboRtuHtnp1JS6w2TSljC36+NtEO7zNYAcGtbeallXTb4k
         ydcBgQcmoDhYbYx6QR7db4U17r+rebBUBfD/9ATDWSkK6xH0Hc14GAKIm2PoVDTef3f/
         ds8zpwTYIFabGYcS5z/zzKPJcn4sNWnZ1vorf+XnPbMI4H1k4zOzb/8TRImAgvLJnxtW
         kpZhMvo2s7ONY5pUybPBafX+7Ls77zc9HWLMGlDJqvYTG0fZdMrMxhx/g+MEblo7NRjV
         o+vZx1fTNrYjozJNUr6NgbEhlBrZIwK9qM9BLzVV1KuUwDPreiISGdLeo8cIkWUHOsdL
         5PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=pHLbO4m6UeqPCuuwhwHghQmO8aGMEWbNr+yVqSETj4o=;
        b=Sy6zrUS6uQE2Fo90tuVSkdsgT/GGLr+bywqJQrEw26XOPnagjjon9yKsfuz8d1OpYE
         I83DIghOewIv5HY2FyLPRZbegpecSv7CRDPM8MjhL3mn4ALPD0QVrifcE6V20mesxQrm
         EPs8AuOLsWCSN+oaNTpzPSPBQc3gjWx0Af4+RbO4MaT4c/d6k9d5RVfHPG7wjytkHOmM
         XVOhjnXyBC7hw1ZuO9UnxGS+jqGTKmgtdZnEJYdfIay9BnDFaKzsuAr7sj0qTZ0Wj9af
         oJ5hVlqrZ4nVHhEeC5LdJnyC76fJw84283PCokW1y5TDbFYSulLNqBsWE/lGm6vqQb61
         m9+g==
X-Gm-Message-State: AOAM5316BSIde04ThuHts2EGdnVTcTiCuJXJI6WPWzp6Wptn3IxKEW8J
        TCCPBlkTS24zdFfPZ7Tk2HgOyw==
X-Google-Smtp-Source: ABdhPJwvbVEqclIRO7t8JWFAPJJQ/82CXZN5CxRHIbtO8zhEN5R0yrNxLmpT/1+FFSeKBi8l/BcxcQ==
X-Received: by 2002:a17:90b:1a89:: with SMTP id ng9mr16550246pjb.36.1616812835203;
        Fri, 26 Mar 2021 19:40:35 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:94d3:b09c:16e0:5994? ([2601:646:c200:1ef2:94d3:b09c:16e0:5994])
        by smtp.gmail.com with ESMTPSA id g10sm9678190pgh.36.2021.03.26.19.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 19:40:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Date:   Fri, 26 Mar 2021 19:40:33 -0700
Message-Id: <89236DB3-7B03-4B11-9F5B-5D820289C544@amacapital.net>
References: <331b34e3d6153f0a7b0ab0a9a8cb5de71f0bfd93.1616803999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <331b34e3d6153f0a7b0ab0a9a8cb5de71f0bfd93.1616803999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 26, 2021, at 5:18 PM, Kuppuswamy Sathyanarayanan <sathyanarayanan.k=
uppuswamy@linux.intel.com> wrote:
>=20
> =EF=BB=BFIn non-root TDX guest mode, MWAIT, MONITOR and WBINVD instruction=
s
> are not supported. So handle #VE due to these instructions as no ops.

These should at least be WARN.

Does TDX send #UD if these instructions have the wrong CPL?  If the #VE came=
 from user mode, we should send an appropriate signal instead.

>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linu=
x.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>=20
> Changes since previous series:
> * Suppressed MWAIT feature as per Andi's comment.
> * Added warning debug log for MWAIT #VE exception.
>=20
> arch/x86/kernel/tdx.c | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>=20
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index e936b2f88bf6..fb7d22b846fc 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -308,6 +308,9 @@ void __init tdx_early_init(void)
>=20
>    setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>=20
> +    /* MWAIT is not supported in TDX platform, so suppress it */
> +    setup_clear_cpu_cap(X86_FEATURE_MWAIT);
> +
>    tdg_get_info();
>=20
>    pv_ops.irq.safe_halt =3D tdg_safe_halt;
> @@ -362,6 +365,26 @@ int tdg_handle_virtualization_exception(struct pt_reg=
s *regs,
>    case EXIT_REASON_EPT_VIOLATION:
>        ve->instr_len =3D tdg_handle_mmio(regs, ve);
>        break;
> +    /*
> +     * Per Guest-Host-Communication Interface (GHCI) for Intel Trust
> +     * Domain Extensions (Intel TDX) specification, sec 2.4,
> +     * some instructions that unconditionally cause #VE (such as WBINVD,
> +     * MONITOR, MWAIT) do not have corresponding TDCALL
> +     * [TDG.VP.VMCALL <Instruction>] leaves, since the TD has been design=
ed
> +     * with no deterministic way to confirm the result of those operation=
s
> +     * performed by the host VMM.  In those cases, the goal is for the TD=

> +     * #VE handler to increment the RIP appropriately based on the VE
> +     * information provided via TDCALL.
> +     */
> +    case EXIT_REASON_WBINVD:
> +        pr_warn_once("WBINVD #VE Exception\n");
> +    case EXIT_REASON_MONITOR_INSTRUCTION:
> +        /* Handle as nops. */
> +        break;
> +    case EXIT_REASON_MWAIT_INSTRUCTION:
> +        /* MWAIT is supressed, not supposed to reach here. */
> +        pr_warn("MWAIT unexpected #VE Exception\n");
> +        return -EFAULT;
>    default:
>        pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
>        return -EFAULT;
> --=20
> 2.25.1
>=20
