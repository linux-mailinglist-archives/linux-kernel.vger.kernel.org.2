Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9500D3A33ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhFJTZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:25:54 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:37411 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhFJTZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:25:52 -0400
Received: by mail-pj1-f47.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so4365942pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q60JAm9iJyX+IT1BVb08j+OKVYIcmui1mNiKIc2o95A=;
        b=FyARXhggC2pK8LeaLL5HzTYgmhxYyXd9tj1XbSmLsO99Ov4/vYm+21l/swFIQTVDLy
         B0KxUZQ9VfHHECcdBtR9tZOyUiLBUDKtk+1e4ECd593H5O9ehHo7mBdAkMBsEm/kGett
         d95PLn0bf1KWgcIZIE62kCCAfnSNKA2VSp48ND88lNtgMeqj22hmdwGoA9wcA7FZPfVO
         gXsgIlqGt0zjTnIAp+Nbu+Vgd297Y5h7I94iBICM1OibHMeNVMyvOpfyprpjHXamRM0g
         +DPEJBJVyng6hN5H7ldwJJH/NkfuHRfbFbxBAfhnJLGCxZsHGeEjA0AI4BBtJ/PXreyt
         MJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q60JAm9iJyX+IT1BVb08j+OKVYIcmui1mNiKIc2o95A=;
        b=bjyH6LCQtpGM8v2SxI2rwMGJivG65wMwlFd9sAEKLGhpMwrfPI/autCiW88DWOd+Z3
         Nyw5r4z4tyeiPb/P+NB+lH1z0U6UyBT8B6VLuPZHgn5wLRK8pV4szS3PqBYOZeoiFnSR
         4Zb5/fKS1+KZXDLCidiniQcc1i+qhv05OlmMzr7nK4ahlSG2jQpDSddLvZN99BWwRPg4
         UQqiKHouU3ZjIoi1C/Lk2Tdgma7KyoLWCh0BODcN8zDcM2jrOPEf8Tn5TL9ZCE+3OGSU
         ONfZceT+8aPvAWVgE6AlDePy+j8Cy8d0bc8+SJ3P3TXm6ciCJSgrnHrt+2GLJG6ukmEC
         gO0Q==
X-Gm-Message-State: AOAM533CVBp6aSTIMy2OfZTQX4LVDNFgQQwNUTiBi9PEUh391kabfBy8
        5G57Q3A73dpKts3N6j3mTpF4Sg==
X-Google-Smtp-Source: ABdhPJyC58KxFV2meI/htR9vylJrOiDouyjMt32X8u8rqNytwI3x3Lr2z+/BjHCU72ocaVuR4ottZg==
X-Received: by 2002:a17:902:b683:b029:ee:f0e3:7a50 with SMTP id c3-20020a170902b683b02900eef0e37a50mr259675pls.7.1623352959723;
        Thu, 10 Jun 2021 12:22:39 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w142sm3187946pff.154.2021.06.10.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:22:38 -0700 (PDT)
Date:   Thu, 10 Jun 2021 19:22:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/43] KVM: x86: vCPU RESET/INIT fixes and consolidation
Message-ID: <YMJme5wSgerifcb5@google.com>
References: <20210424004645.3950558-1-seanjc@google.com>
 <6ac56ad5-7475-c99f-0ca4-171bc3da45b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac56ad5-7475-c99f-0ca4-171bc3da45b5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021, Paolo Bonzini wrote:
> I'm waiting for a v2 of this; it applies with relatively few conflicts, but
> there were some comments so it's better if you take care of updating it.

Ya, slowly getting there...  Something in this series (I can't even remember what)
sent me into the morass that is unsync shadow pages and I've been thrashing around
in there for a while.
