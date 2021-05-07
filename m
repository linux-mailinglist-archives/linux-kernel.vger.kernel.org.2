Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DC4376153
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhEGHmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233523AbhEGHl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620373259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2epZ2nUOx96a/509EcQy2qQ0oq17gDoVWNxT6qATfiY=;
        b=WF2GZaXw20mWmJZ6Xw3CfeHNEjL6k9Bfk5nJNgWPX2m8Uck5W5zKEEdcJeF2sbCYROrUdl
        cZ2fQaUp7PfNwBubUql2p0Cqoal44G8iJqZ24kQPfRBkvcJt9utpmSoBGYDFjAYjctBCpB
        7yKYk+3wki5PHNktf4lSp589RDtEgNA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-UqXnfP-2NwOogltIDenCOA-1; Fri, 07 May 2021 03:40:58 -0400
X-MC-Unique: UqXnfP-2NwOogltIDenCOA-1
Received: by mail-ed1-f72.google.com with SMTP id y15-20020aa7d50f0000b02903885ee98723so3986688edq.16
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2epZ2nUOx96a/509EcQy2qQ0oq17gDoVWNxT6qATfiY=;
        b=lUS6fQKpqkjsrDOPDdj245pWJvyS/Ju/snIwkNfT0IAmD9DUqRdcpf0TjAAEexJFdI
         iLGaG+eHsqfmsLW+c/j4waCL82JS1UTT3J9KWxN/iEyoYAEUIijdHOMBB3SQ0M2YYftp
         zSQcFxU/R/5/7av3o6Qpv5hPjYUKQ8FwozeHd3htJqVJCMtscC7wQfEzDlpMAcFxEeqj
         uO5Lmydpcmk87v6Rnpw/sx0+2ZU+xNFnNr1foc3WOS/kQVrnfTTLvUZ3NfcPW57jsUjX
         vYjTR4nc6xdf15c67G30n9+GUFy3x/l/mnjtyWpKViSjo2pgax1YGbGllaiRU1DGU539
         qizw==
X-Gm-Message-State: AOAM5333XLf3yHPqzLZUb+/D22moFdMNTC8G7FmztfZ2ND4mRenv9ZYL
        XH9BvStQ+XnP2TYosEGbPKM8wVs7Z92t8hv/Ifv1C3LWm05ZiIxCrUft/36xaxbbnQVQB+/ZSJG
        0z4W4shKLGf54KnE39160eBwe
X-Received: by 2002:a05:6402:430e:: with SMTP id m14mr9958692edc.308.1620373256929;
        Fri, 07 May 2021 00:40:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz55jU7yEJ+wE3P0zZA9dMMi2B9lZBUVdKrFk+Wbwos/coyARDHUdjx2QUEjymy9DpGmmP2Ig==
X-Received: by 2002:a05:6402:430e:: with SMTP id m14mr9958676edc.308.1620373256781;
        Fri, 07 May 2021 00:40:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id j4sm2935157ejk.37.2021.05.07.00.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 00:40:56 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Invert user pointer casting in SEV {en,de}crypt
 helpers
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>
References: <20210506231542.2331138-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38d86d4c-6578-18f6-067c-a6386c5c8005@redhat.com>
Date:   Fri, 7 May 2021 09:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506231542.2331138-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/21 01:15, Sean Christopherson wrote:
> Invert the user pointer params for SEV's helpers for encrypting and
> decrypting guest memory so that they take a pointer and cast to an
> unsigned long as necessary, as opposed to doing the opposite.  Tagging a
> non-pointer as __user is confusing and weird since a cast of some form
> needs to occur to actually access the user data.  This also fixes Sparse
> warnings triggered by directly consuming the unsigned longs, which are
> "noderef" due to the __user tag.
> 
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Ashish Kalra <ashish.kalra@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/svm/sev.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index a9d8d6aafdb8..bba4544fbaba 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -763,7 +763,7 @@ static int __sev_dbg_decrypt(struct kvm *kvm, unsigned long src_paddr,
>   }
>   
>   static int __sev_dbg_decrypt_user(struct kvm *kvm, unsigned long paddr,
> -				  unsigned long __user dst_uaddr,
> +				  void __user *dst_uaddr,
>   				  unsigned long dst_paddr,
>   				  int size, int *err)
>   {
> @@ -787,8 +787,7 @@ static int __sev_dbg_decrypt_user(struct kvm *kvm, unsigned long paddr,
>   
>   	if (tpage) {
>   		offset = paddr & 15;
> -		if (copy_to_user((void __user *)(uintptr_t)dst_uaddr,
> -				 page_address(tpage) + offset, size))
> +		if (copy_to_user(dst_uaddr, page_address(tpage) + offset, size))
>   			ret = -EFAULT;
>   	}
>   
> @@ -800,9 +799,9 @@ static int __sev_dbg_decrypt_user(struct kvm *kvm, unsigned long paddr,
>   }
>   
>   static int __sev_dbg_encrypt_user(struct kvm *kvm, unsigned long paddr,
> -				  unsigned long __user vaddr,
> +				  void __user *vaddr,
>   				  unsigned long dst_paddr,
> -				  unsigned long __user dst_vaddr,
> +				  void __user *dst_vaddr,
>   				  int size, int *error)
>   {
>   	struct page *src_tpage = NULL;
> @@ -810,13 +809,12 @@ static int __sev_dbg_encrypt_user(struct kvm *kvm, unsigned long paddr,
>   	int ret, len = size;
>   
>   	/* If source buffer is not aligned then use an intermediate buffer */
> -	if (!IS_ALIGNED(vaddr, 16)) {
> +	if (!IS_ALIGNED((unsigned long)vaddr, 16)) {
>   		src_tpage = alloc_page(GFP_KERNEL);
>   		if (!src_tpage)
>   			return -ENOMEM;
>   
> -		if (copy_from_user(page_address(src_tpage),
> -				(void __user *)(uintptr_t)vaddr, size)) {
> +		if (copy_from_user(page_address(src_tpage), vaddr, size)) {
>   			__free_page(src_tpage);
>   			return -EFAULT;
>   		}
> @@ -830,7 +828,7 @@ static int __sev_dbg_encrypt_user(struct kvm *kvm, unsigned long paddr,
>   	 *   - copy the source buffer in an intermediate buffer
>   	 *   - use the intermediate buffer as source buffer
>   	 */
> -	if (!IS_ALIGNED(dst_vaddr, 16) || !IS_ALIGNED(size, 16)) {
> +	if (!IS_ALIGNED((unsigned long)dst_vaddr, 16) || !IS_ALIGNED(size, 16)) {
>   		int dst_offset;
>   
>   		dst_tpage = alloc_page(GFP_KERNEL);
> @@ -855,7 +853,7 @@ static int __sev_dbg_encrypt_user(struct kvm *kvm, unsigned long paddr,
>   			       page_address(src_tpage), size);
>   		else {
>   			if (copy_from_user(page_address(dst_tpage) + dst_offset,
> -					   (void __user *)(uintptr_t)vaddr, size)) {
> +					   vaddr, size)) {
>   				ret = -EFAULT;
>   				goto e_free;
>   			}
> @@ -935,15 +933,15 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
>   		if (dec)
>   			ret = __sev_dbg_decrypt_user(kvm,
>   						     __sme_page_pa(src_p[0]) + s_off,
> -						     dst_vaddr,
> +						     (void __user *)dst_vaddr,
>   						     __sme_page_pa(dst_p[0]) + d_off,
>   						     len, &argp->error);
>   		else
>   			ret = __sev_dbg_encrypt_user(kvm,
>   						     __sme_page_pa(src_p[0]) + s_off,
> -						     vaddr,
> +						     (void __user *)vaddr,
>   						     __sme_page_pa(dst_p[0]) + d_off,
> -						     dst_vaddr,
> +						     (void __user *)dst_vaddr,
>   						     len, &argp->error);
>   
>   		sev_unpin_memory(kvm, src_p, n);
> 

Queued, thnaks.

Paolo

