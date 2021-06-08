Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06E639EAF4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFHAsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:48:06 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:33780 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhFHAsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:48:05 -0400
Received: by mail-pl1-f169.google.com with SMTP id c13so9713702plz.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 17:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TkL1IBMNyy9LCho9RG5yvgyLt1iIVTJx8MHgf8Y6U3Q=;
        b=NnvpGsbQtNYBBeTeM6yzv5NrHus0ByzFMz20705XPCu1/dSzypTKxHlFJW43TR2PR3
         0obMNKXskwYtyXSeiadXUVm3o5qobDG6N6AtuqD2394l492Fq3cR2nzKvvuz+ewY0suQ
         z7bWYCd3lC1ughiUCrM+LIy7CroaG02VEwtwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TkL1IBMNyy9LCho9RG5yvgyLt1iIVTJx8MHgf8Y6U3Q=;
        b=Jo28USITyHLFaTuunLWg4QQ9cwTKbmFNcYess8+m9ccJnfVtBJPS52WaWxgsX1J8sn
         vgjyZewBBuDRkx5URYcc7FYST0qrVIySTXFjfw1J3eWiyVVafw0kxcuyYT9Bt76Doq+J
         uOxn/mwGv0w+1e4lNA/pWxtlG1d44oYxkA8Pkcxsoz6H5xBGhCNOH0aoNS8r/jw9iTMD
         L7BiuI8sz5U3FqqBwjhlb388DfNa/Wi8RIRxgz7YweMOgZ1GvK0w+TWEgeJiZ136DdSu
         GGg/8xNeDeCbnf+yV5L8ZSa1sofRGXliltiwO1DnZp7y+yxSS/m+7mkoN82Wu6tr11S5
         b7Gw==
X-Gm-Message-State: AOAM5303LqgwH2rypZ6gSgqq5GVfAp5kAdAIgP6f8UEA54SwAkN4YfsD
        WDpAh1HGuL7bBQbe/pvJ6MXCTw==
X-Google-Smtp-Source: ABdhPJyApYLIqMYQ7LGTK2gmVHqQ5rm0+vYcRttlyB+830rpLYbWYZEJuWO+4t5lsTF787gTN6Uhng==
X-Received: by 2002:a17:90a:4dc1:: with SMTP id r1mr23121759pjl.192.1623113096781;
        Mon, 07 Jun 2021 17:44:56 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:1193:5ba8:74e4:8b6e])
        by smtp.gmail.com with ESMTPSA id r9sm9311391pfq.158.2021.06.07.17.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 17:44:56 -0700 (PDT)
Date:   Tue, 8 Jun 2021 09:44:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/2] kvm: x86: implement KVM PM-notifier
Message-ID: <YL69g007MKqxiZG/@google.com>
References: <20210606021045.14159-1-senozhatsky@chromium.org>
 <20210606021045.14159-2-senozhatsky@chromium.org>
 <fe13fe734a01bb54f47fea06624c617beb062fdd.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe13fe734a01bb54f47fea06624c617beb062fdd.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/07 15:54), Maxim Levitsky wrote:
> 
> Overall this looks OK to me.
>  
> Do you have a test case in which this patch helps to make the guest behave better after
> the host suspend though? I tested this and I don't see any significant change.
> (guest works after host suspend before and after, and I still have clocksource
> watchdogs firing in the guest)

Yes, we have automated suspend-resume tests. What happens for us is that,
when not properly paused, guests, upon host resume, discover jiffies spikes
and trigger all sort of watchdogs.
