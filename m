Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D856335A78A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhDIUAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhDIUAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:00:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D07C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 13:00:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id j26so7104723iog.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cgshE6EYnolIShLRm5FI9d7+7bz8uNIyn1uZIy0SnYk=;
        b=P+0ssMYSZARmrpU7MaDh0LAz4Nsm9BirVFy68Wgek1heXXY45shgwR8l2yCLMRixvM
         gHejADh8yLI1kWEwJsl96uXZXuXBktI7xPT76f+/Iq9q3JV//4UITVQpA4y1ENRQE9LF
         aRbV35/My1YsmojhyfG/Pxadmg73YZ+GzD6Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgshE6EYnolIShLRm5FI9d7+7bz8uNIyn1uZIy0SnYk=;
        b=sJyA6+G9ch5Ya93mi4ob4By3qAIjyLEbV+TqvYBwcwtUtB5AL76mMCySzkFEzkX+Bd
         auJJV/3a7PCPC44VCfxFA0supaDSHddLZkosghRtPONWVQsKd8IISJFd7bD27uRfauLV
         hdvYx1SQMT2o3RotHnLlTTcHo3fk/bUBneoO524cUfxmCH2zo6lZs2LOKYauKt1aWDVF
         cgfT8y2b11+114A2ML3FW2ECO7rArct9HFY6S6rYuiPsAS5t1b1zQvmBp50z01pkUuLP
         mbiFHC3wH0QSIvoCkal1CRPBcA3VDeU6jYbOoEwjuqJzzo6eAdrIu8TdkMATnac89BBw
         442A==
X-Gm-Message-State: AOAM5310lb3aAcLYlcpk1NjdZdWXlzzdVaJ11Yh89ssWuhPTD4nXVLmA
        +DOAOBlpPG+04OlBCxUC/1FJlg==
X-Google-Smtp-Source: ABdhPJzChhxXyqliGmiCUhlRXZWNybL45CB4wGrK1sdALXTbkRB6XEqjA6pDuJdJ5sHy+1Fcaz75uQ==
X-Received: by 2002:a02:850a:: with SMTP id g10mr16476595jai.140.1617998435941;
        Fri, 09 Apr 2021 13:00:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o6sm1658992ioa.21.2021.04.09.13.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 13:00:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de, Jon.Grimm@amd.com,
        Tj <ml.linux@elloe.vision>,
        Alexander Monakov <amonakov@ispras.ru>,
        David Coe <david.coe@live.co.uk>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4f007897-afac-35e3-9c76-281c94d660c7@linuxfoundation.org>
Date:   Fri, 9 Apr 2021 14:00:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/21 2:58 AM, Suravee Suthikulpanit wrote:
> In early AMD desktop/mobile platforms (during 2013), when the IOMMU
> Performance Counter (PMC) support was first introduced in
> commit 30861ddc9cca ("perf/x86/amd: Add IOMMU Performance Counter
> resource management"), there was a HW bug where the counters could not
> be accessed. The result was reading of the counter always return zero.
> 
> At the time, the suggested workaround was to add a test logic prior
> to initializing the PMC feature to check if the counters can be programmed
> and read back the same value. This has been working fine until the more
> recent desktop/mobile platforms start enabling power gating for the PMC,
> which prevents access to the counters. This results in the PMC support
> being disabled unnecesarily.
> 
> Unfortunatly, there is no documentation of since which generation
> of hardware the original PMC HW bug was fixed. Although, it was fixed
> soon after the first introduction of the PMC. Base on this, we assume
> that the buggy platforms are less likely to be in used, and it should
> be relatively safe to remove this legacy logic.
> 
> Link: https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
> Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Alexander Monakov <amonakov@ispras.ru>
> Cc: David Coe <david.coe@live.co.uk>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---


Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

Results with this patch on AMD Ryzen 5 PRO 2400GE w/ Radeon Vega
Graphics

sudo ./perf stat -e 'amd_iommu_0/cmd_processed/, 
amd_iommu_0/cmd_processed_inv/, amd_iommu_0/ign_rd_wr_mmio_1ff8h/, 
amd_iommu_0/int_dte_hit/, amd_iommu_0/int_dte_mis/, 
amd_iommu_0/mem_dte_hit/, amd_iommu_0/mem_dte_mis/, 
amd_iommu_0/mem_iommu_tlb_pde_hit/, amd_iommu_0/mem_iommu_tlb_pde_mis/, 
amd_iommu_0/mem_iommu_tlb_pte_hit/, amd_iommu_0/mem_iommu_tlb_pte_mis/, 
amd_iommu_0/mem_pass_excl/, amd_iommu_0/mem_pass_pretrans/, 
amd_iommu_0/mem_pass_untrans/, amd_iommu_0/mem_target_abort/, 
amd_iommu_0/mem_trans_total/, amd_iommu_0/page_tbl_read_gst/, 
amd_iommu_0/page_tbl_read_nst/, amd_iommu_0/page_tbl_read_tot/, 
amd_iommu_0/smi_blk/, amd_iommu_0/smi_recv/, amd_iommu_0/tlb_inv/, 
amd_iommu_0/vapic_int_guest/, amd_iommu_0/vapic_int_non_guest/' sleep 10

  Performance counter stats for 'system wide':

                156      amd_iommu_0/cmd_processed/ 
                 (33.30%)
                 80       amd_iommu_0/cmd_processed_inv/ 
                      (33.38%)
                  0       amd_iommu_0/ign_rd_wr_mmio_1ff8h/ 
                         (33.40%)
                  0       amd_iommu_0/int_dte_hit/ 
                (33.43%)
                325       amd_iommu_0/int_dte_mis/ 
                (33.44%)
              1,951       amd_iommu_0/mem_dte_hit/ 
                (33.45%)
              7,589       amd_iommu_0/mem_dte_mis/ 
                (33.49%)
                325       amd_iommu_0/mem_iommu_tlb_pde_hit/ 
                          (33.45%)
              2,460       amd_iommu_0/mem_iommu_tlb_pde_mis/ 
                          (33.41%)
              2,510       amd_iommu_0/mem_iommu_tlb_pte_hit/ 
                          (33.38%)
              5,526       amd_iommu_0/mem_iommu_tlb_pte_mis/ 
                          (33.33%)
                  0       amd_iommu_0/mem_pass_excl/ 
                  (33.29%)
                  0       amd_iommu_0/mem_pass_pretrans/ 
                      (33.28%)
              1,556       amd_iommu_0/mem_pass_untrans/ 
                     (33.27%)
                  0       amd_iommu_0/mem_target_abort/ 
                     (33.26%)
              3,112       amd_iommu_0/mem_trans_total/ 
                    (33.29%)
                  0       amd_iommu_0/page_tbl_read_gst/ 
                      (33.29%)
              1,813       amd_iommu_0/page_tbl_read_nst/ 
                      (33.25%)
              2,242       amd_iommu_0/page_tbl_read_tot/ 
                      (33.27%)
                  0       amd_iommu_0/smi_blk/ 
                (33.29%)
                  0       amd_iommu_0/smi_recv/ 
                (33.28%)
                  0       amd_iommu_0/tlb_inv/ 
                (33.28%)
                  0       amd_iommu_0/vapic_int_guest/ 
                    (33.25%)
                  0       amd_iommu_0/vapic_int_non_guest/ 
                        (33.26%)

       10.003200316 seconds time elapsed

