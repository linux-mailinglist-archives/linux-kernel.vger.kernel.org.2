Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5093FE602
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbhIAXNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 19:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242052AbhIAXNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630537960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VbIfjKWHJ8KB1V8GBiccCt4CfSridAvT1ZyldnMra2Q=;
        b=RNyzh0iE6CJ632P5+RWrtiHeQ5q++iaIcBDsONOwL6u6I+EYKtXpUSh0MfTVanyiAFEdUx
        uAbYVg/93CfTq3+i6aR+7u9779qPKW/D53+voulYWAQc98mtUAH1nvE/mv4PFkORR/OP2T
        QO3dgWwZ13twDcphkRrUTtDU332wbRg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-2J6O-P_nP1GNQApmNAm_NA-1; Wed, 01 Sep 2021 19:12:39 -0400
X-MC-Unique: 2J6O-P_nP1GNQApmNAm_NA-1
Received: by mail-qt1-f200.google.com with SMTP id e8-20020a05622a110800b0029ecbdc1b2aso1104077qty.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VbIfjKWHJ8KB1V8GBiccCt4CfSridAvT1ZyldnMra2Q=;
        b=EaYXWI5650oHuZKNcv2KHWrGa26IzjCorRzv/D/qPfEThoKBljmVP92M+Ep5Xnjfba
         PktGX4m641XPHHvZi4xiDZ15km8wTqv0RuVs4m0CFLJnK64crKEmcXd+jE+xCgeXT4lK
         rKzB+VDy3vUuU2gIH/XbCVizmesJvSJRURy9YjOpHP31QSTH6mI1yksnsl0YQclpgbAA
         WeSg4ZAjbNOdYMSWODDdhPZ2b/nmn+mccEtbSEulebmqPikQrn59kfFiuGtS1/lPtmQx
         mgl5yEqlv1ImjwqvZFrHTmBtBYkRnbctHv6Pd7hqPYGD3PRX4YUVHvkPpeDMr5i42eQS
         ZAUA==
X-Gm-Message-State: AOAM532RaRPx83+eyI8j4eE5UTXjniNN++oLmd5Am376sQyuCa7LKa1F
        O4LUkeHBMxo7OXQCSH5gyAep5vWSAB7r/GICE1wJin4hnQJ7ardLp8Ph8bDfePCi479HXozrUjE
        x8jx+EFUEIt3Ksj3C+ko1d20d
X-Received: by 2002:a05:622a:44f:: with SMTP id o15mr240161qtx.260.1630537958531;
        Wed, 01 Sep 2021 16:12:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOT/s2C/lqO1N5pj2/GH+enIBmAzz3KZmz02wac1AEISnxd7j6xiH+IWWt96jE00AuM9qZvQ==
X-Received: by 2002:a05:622a:44f:: with SMTP id o15mr240145qtx.260.1630537958310;
        Wed, 01 Sep 2021 16:12:38 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id c23sm96797qkk.50.2021.09.01.16.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:12:37 -0700 (PDT)
Date:   Wed, 1 Sep 2021 19:12:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: arch/x86/kvm/../../../virt/kvm/dirty_ring.c:94:20: error: unused
 function 'kvm_dirty_gfn_invalid'
Message-ID: <YTAI5NE6MZ+J+5oM@t490s>
References: <202109020620.e6EZVLvS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202109020620.e6EZVLvS-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 06:22:29AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   477f70cd2a67904e04c2c2b9bd0fa2e95222f2f6
> commit: fb04a1eddb1a65b6588a021bdc132270d5ae48bb KVM: X86: Implement ring-based dirty memory tracking
> date:   10 months ago
> config: i386-randconfig-r005-20210901 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4b1fde8a2b681dad2ce0c082a5d6422caa06b0bc)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb04a1eddb1a65b6588a021bdc132270d5ae48bb
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout fb04a1eddb1a65b6588a021bdc132270d5ae48bb
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/x86/kvm/../../../virt/kvm/dirty_ring.c:94:20: error: unused function 'kvm_dirty_gfn_invalid' [-Werror,-Wunused-function]
>    static inline bool kvm_dirty_gfn_invalid(struct kvm_dirty_gfn *gfn)
>                       ^
>    1 error generated.
> 
> 
> vim +/kvm_dirty_gfn_invalid +94 arch/x86/kvm/../../../virt/kvm/dirty_ring.c
> 
>     93	
>   > 94	static inline bool kvm_dirty_gfn_invalid(struct kvm_dirty_gfn *gfn)
>     95	{
>     96		return gfn->flags == 0;
>     97	}
>     98	

https://lore.kernel.org/lkml/20210901230904.15164-1-peterx@redhat.com

Thanks,

-- 
Peter Xu

