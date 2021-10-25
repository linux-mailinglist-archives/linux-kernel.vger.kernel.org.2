Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50CA4391DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhJYJBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232386AbhJYJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635152351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzTYvmR+Baxf4vvutXG9y4UJh2DkglRXKqKaxVfskag=;
        b=ChAQLm/QTahcyCd9pMyogd/XCnnW02OEUCpFSturPpV8Z2ONLmrgMOXBxPpaim/mCPa1hh
        USZOq13fbRDiDEysENiI96ugP0hrq0wR+Q3ldpjxThV5VIVeLBcbN+EvlrsKt7Nfux7alg
        koVYGugOcq0X0vvNt0LwN39JBDnBZ7c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-YAOaTqMeOOSVcHKV-QtW8A-1; Mon, 25 Oct 2021 04:59:09 -0400
X-MC-Unique: YAOaTqMeOOSVcHKV-QtW8A-1
Received: by mail-ed1-f72.google.com with SMTP id x13-20020a05640226cd00b003dd4720703bso3272622edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OzTYvmR+Baxf4vvutXG9y4UJh2DkglRXKqKaxVfskag=;
        b=Z5FJrK1KXNZSAzn9RlCro49dl8ZxKUiIindkOtKPOR9p1ZRNRbcPq+upO+RDH+VxNE
         RLBVzeeYyIwaqKDBTj4FVLX5b7D4dog7FTvnjW8MY0eSYxICb2SX1ilxnfPjHKjm/mXy
         HqKuZ6UUS6zhPlkBXj74uEUB4xxhzGUgVCMIau+uvzsFXuao2QfUJBX6klSCMDuPlpW8
         D9nxzK4NvJ5tJzNUd0a6uF0t8FGJAqN4mZ416fP+kxqy7bV9ux390FfcciXUk92cRniC
         IHnvQDOP2fd5IbOw0NBohhsxzF6lOt7teK7pQcI32/QvXZeCIDEXUfMqgeyOB5gMOfxm
         ymEw==
X-Gm-Message-State: AOAM531lwuylz5heJw1lf9/EPr/xWnz60tnVIrNh/0qnN/oYUVZjLp1l
        dfJwc6Z7y5Y2Xrclezl/Q+MFR0MyIkT+lKRml7u9j4QUp3qDqdeQed/CuTtrCcsUekMzFoevVYM
        2IazAIx1KSQp6D+lGnrXbNvhY
X-Received: by 2002:a17:907:7f11:: with SMTP id qf17mr10287102ejc.437.1635152348473;
        Mon, 25 Oct 2021 01:59:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkmP22ASf0et7zE/OEQYMrGgdxDWBcd2eTY+zIf1qIM2FQEJlIVcKFfdA+RQYOcmccNWPBtw==
X-Received: by 2002:a17:907:7f11:: with SMTP id qf17mr10287084ejc.437.1635152348257;
        Mon, 25 Oct 2021 01:59:08 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id he14sm3901907ejc.34.2021.10.25.01.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 01:59:07 -0700 (PDT)
Message-ID: <707a0a5d-413e-b80d-89be-17bfca8fc44c@redhat.com>
Date:   Mon, 25 Oct 2021 10:59:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/8] KVM: SEV-ES: fix length of string I/O
Content-Language: en-US
To:     Marc Orr <marcorr@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        fwilhelm@google.com, seanjc@google.com, oupton@google.com,
        stable@vger.kernel.org
References: <20211013165616.19846-1-pbonzini@redhat.com>
 <20211013165616.19846-2-pbonzini@redhat.com>
 <CAA03e5F8qvkbnPNvDHjrnM1hLs2fu5L_Mxtuhi3T5Y7u+_ydrw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAA03e5F8qvkbnPNvDHjrnM1hLs2fu5L_Mxtuhi3T5Y7u+_ydrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/21 03:31, Marc Orr wrote:
> I could be missing something, but I'm pretty sure that this is wrong.
> The GHCB spec says that `exit_info_2` is the `rep` count. Not the
> string length.
> 
> For example, given a `rep outsw` instruction, with `ECX` set to `8`,
> the rep count written into `SW_EXITINFO2` should be eight x86 words
> (i.e., 16 bytes) and the IO size should be one x86 word (i.e., 2
> bytes). In other words, the code was correct before this patch. This
> patch is incorrectly dividing the rep count by the IO size, causing
> the string IO to be truncated.

Then what's wrong is _also_ the call to setup_vmgexit_scratch, because 
that one definitely expects bytes:

                 scratch_va = kzalloc(len, GFP_KERNEL_ACCOUNT);

Paolo

