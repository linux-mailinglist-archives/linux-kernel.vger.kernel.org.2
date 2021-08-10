Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2443E527F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhHJE6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbhHJE6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:58:11 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD7C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:57:50 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id b25-20020a4ac2990000b0290263aab95660so5013630ooq.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzIb/ALC5uOWJQxpcPBbJjvGksioyH36daLuKghiHvM=;
        b=c0FITYn9LmtYp+Fa/PwYe1ydEJp02qgTJpSn/ArFf4psnFIQSeDxgGESgqIMKZLiVA
         KbqzDsuBk5Lk5hZ6D42YbUGBACnkoRC0fGQN4WN3UIbKx55/7Wbata/iDz6KgHxThZ9L
         ZoMhypSwa+pPwMKe2XmVnwTAJMkahr20XIavtGV1bJ4nyz7RVEpW7SgUwQ3aZGdwl+Rc
         iTKWtyKpXFJ3FdIElreai6cs2X0ZPNbiztQJ758+JBNvddgqUCBC8xTutHChnGiD+/Oy
         jdsJyX+abDiPYFRzvDcc/XIWuumQTCc0amugFHMQBwjU3sThHWVPOBLAGsT2Sjs5FG7q
         jweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzIb/ALC5uOWJQxpcPBbJjvGksioyH36daLuKghiHvM=;
        b=HRHI5b4nJQIBsS7vY7BkHWuRHpZAYqyO/Un3UReFOdeGnaQTjz9oMQZFwK+lRYACSZ
         7uhmeTNP/EfXsYxmt4ifx/g2VkCzRJD2RbwfDPWY//+Zn8/LDECfXiwXeHOEyY6jhB+2
         1gDFDlB2YDMSJx3Q3Em42ctA1L6TfFPqYDFIbySv6BkT+OmdPDO4qTNjEckWLszE0OSs
         03gAREa3OdOHfTaZZvIopDyGSoj9aukRzypng4hv/3l0kgZp0j5wWwQW79mNAgV3nG1V
         in6JNWib5IbWL+mv11GtnNZ3Qrm6jU6cbSdiw0B4odxI3BjoLE/iKqA3UQwDHVc+QROA
         mjSg==
X-Gm-Message-State: AOAM530R4sb7cS0p5NjAjVX2xFNM3wwFvvqqZWiWoseHN+qdIUSLAeVR
        lJWn8hHN8bsuK+olToZHelyiPYiB3o6aEkVWXiARvA==
X-Google-Smtp-Source: ABdhPJwB2hq8/JcoLsWH5ScDehx0CJBEyn2OBkWhzQB2UgK0UtrlGIYvud3gzCmKUmah6AUNeEJfaFCoQh5ryEa9cdw=
X-Received: by 2002:a4a:4c55:: with SMTP id a82mr17509260oob.66.1628571469459;
 Mon, 09 Aug 2021 21:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com> <20210809152448.1810400-15-qperret@google.com>
In-Reply-To: <20210809152448.1810400-15-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 10 Aug 2021 06:57:13 +0200
Message-ID: <CA+EHjTyxW_X-xjn7opfrLFWXupfjMzCZFVBYZjgpaqLbxbjDVQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/21] KVM: arm64: Expose pkvm_hyp_id
To:     Quentin Perret <qperret@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Mon, Aug 9, 2021 at 5:25 PM Quentin Perret <qperret@google.com> wrote:
>
> Allow references to the hypervisor's owner id from outside
> mem_protect.c.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 2 ++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 0849ee8fa260..23316a021880 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -46,6 +46,8 @@ struct host_kvm {
>  };
>  extern struct host_kvm host_kvm;
>
> +extern const u8 pkvm_hyp_id;
> +
>  int __pkvm_prot_finalize(void);
>  int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index f95a5a4aa09c..ee255171945c 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -31,7 +31,7 @@ static struct hyp_pool host_s2_pool;
>  u64 id_aa64mmfr0_el1_sys_val;
>  u64 id_aa64mmfr1_el1_sys_val;
>
> -static const u8 pkvm_hyp_id = 1;
> +const u8 pkvm_hyp_id = 1;
>
>  static void *host_s2_zalloc_pages_exact(size_t size)
>  {
> --
> 2.32.0.605.g8dce9f2422-goog
>
