Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0BE436EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 02:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhJVAJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 20:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhJVAJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:09:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA916C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 17:07:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so1802909pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 17:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+jlgRFwnJ1/FtYL8jm3CCi7efIQzRtDfAIcFqpNJGu8=;
        b=Z654asXvZrBq9WHqb2kztsS3sX8ZAVNW0wxrTyYvIFD2z0VGaqX/ujGPgYnL3MWih5
         MEmNJtoyMRsErpS12FPpm9H5evy1CH84yeMirwt2hyaT45y2kw2lvPkg23pnrUERPTTX
         PEuOqk9F4qVNbNpUZ5p0ERwJplXm9OyuBjFT3WemfSpvX/YKAhJ52cTZfMrZGm02HWJL
         WcaA7Yr/r9YdJ3YlEK9c+wYHXy6vHnCJtGHVToxthMlKPMzLQ20SJS45gKHe7dzWp31h
         L7EiHm/q7uaWbMWpPm9ucIqvUa8q5T9GtqmLQYWHHz9zb186FVq5l5Idu78yhlyL6OvN
         Qcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+jlgRFwnJ1/FtYL8jm3CCi7efIQzRtDfAIcFqpNJGu8=;
        b=c84ywMX5ZTycXvNzkvG1q7zCL1WXC/eRW2Qxr1sgTZ8YMJoLQN2HsuQO3NK93lxek3
         n3Avt59L0uWPgGeHI++ttqGsxS0U4gU+qD6lH2WFh8yTH9jWJNI36dfNlzKND5eexrI6
         E+My/0OI6Vto2KzbS1ku1Qbf0T7GsL5xqehWHm8s6rZBfZGHrFtRSJerkDliJOVp4qMg
         CZkcWQ12KJvwRRttTOhHS/PB8oMFZffCJnRDmjpNog3LVGDXM3Jth2zjV2lkGQqN1rq2
         Scs3wrx8wOR5VQgrP8DvxDaTxxB4sraZemorkOH4jXTNVnlDpFLCcdKGMV1jHmGLECXg
         K/ng==
X-Gm-Message-State: AOAM532+jLnOrt3tUe1yu79pG8WUE7UNG9W35HCnyw3KBhPNmf6D4Dr2
        0sLY4eBO700Zw7eUWupdJ3t/RQ==
X-Google-Smtp-Source: ABdhPJyDLv1Im87PgbSQr+kIu5kcXVmfb5EQCZJ6zChVpVaBIDxU/7gaaDhI8fOwNH+KKxQOc3enHA==
X-Received: by 2002:a17:90b:4a8b:: with SMTP id lp11mr10789603pjb.46.1634861253523;
        Thu, 21 Oct 2021 17:07:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u2sm7053088pfi.120.2021.10.21.17.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 17:07:32 -0700 (PDT)
Date:   Fri, 22 Oct 2021 00:07:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bp@suse.de,
        dave.hansen@linux.intel.com, jarkko@kernel.org,
        yang.zhong@intel.com, x86@kernel.org
Subject: Re: [PATCH v4 2/2] x86: sgx_vepc: implement SGX_IOC_VEPC_REMOVE ioctl
Message-ID: <YXIAwM0b+kIsx4af@google.com>
References: <20211021201155.1523989-1-pbonzini@redhat.com>
 <20211021201155.1523989-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021201155.1523989-3-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021, Paolo Bonzini wrote:
> For bare-metal SGX on real hardware, the hardware provides guarantees
> SGX state at reboot.  For instance, all pages start out uninitialized.
> The vepc driver provides a similar guarantee today for freshly-opened
> vepc instances, but guests such as Windows expect all pages to be in
> uninitialized state on startup, including after every guest reboot.
> 
> Some userspace implementations of virtual SGX would rather avoid having
> to close and reopen the /dev/sgx_vepc file descriptor and re-mmap the
> virtual EPC.  For example, they could sandbox themselves after the guest
> starts and forbid further calls to open(), in order to mitigate exploits
> from untrusted guests.
> 
> Therefore, add a ioctl that does this with EREMOVE.  Userspace can
> invoke the ioctl to bring its vEPC pages back to uninitialized state.
> There is a possibility that some pages fail to be removed if they are
> SECS pages, and the child and SECS pages could be in separate vEPC
> regions.  Therefore, the ioctl returns the number of EREMOVE failures,
> telling userspace to try the ioctl again after it's done with all
> vEPC regions.  A more verbose description of the correct usage and
> the possible error conditions is documented in sgx.rst.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
