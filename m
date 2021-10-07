Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6781C4257AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbhJGQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242606AbhJGQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633623523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g2BhWp9ye5wWG2ktl9BRS9ejL5FqZFg78PPEny8VjKw=;
        b=hLmCdAqEvZWZzAQngalY8cNIQJJYQ6eIS37ZFPh70EluAbj2vj4EcAG7g5ppfzLULFtt5k
        ZGtGwIeM9hdFLeJsimRz2lThYDTikIbppX+/pqMJG5vlwYX3Hmqz9krB01kmED4pdyC/tg
        j+j4mSFca7tcKrG7treJSWBktNGN6CY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-5pNWxzxiNYyiMeU88bL81g-1; Thu, 07 Oct 2021 12:18:41 -0400
X-MC-Unique: 5pNWxzxiNYyiMeU88bL81g-1
Received: by mail-qv1-f69.google.com with SMTP id kk3-20020a056214508300b00382d8d1bd71so6123621qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g2BhWp9ye5wWG2ktl9BRS9ejL5FqZFg78PPEny8VjKw=;
        b=5yQMpufUBIxMNfyWkspU8JvUagjBAv82JfeA7cWtRmqZ59J7tzbtTJ7yTKSB7+WEPG
         zrJLv3Zip8U5Wbt2Fc6n5VBR1hEWmx4r+IOAgbDwbZpvQ25+JyBpnvGbd//MkET+nLW6
         kFbufKHaqtMFKKbPtWYge601nfvYS0PE0ld/jzGX5wP1q+Ouue+oQhiq9UnTLwXl89sZ
         JFl5lnr+TJ9n7N4PZ5ZYTY2i+8CFKmuFctkHbYs2ap4sHDCO56DE41VOBibUyBSl5gQi
         OLmpYBGzkPkAzJ5oV09svBFoeKast6LemM0t+EHv0SqP7zDOHU89Cai0V9dXtVJgjof7
         4Tpg==
X-Gm-Message-State: AOAM532Uu2UOv1mSHQcg114rZwfLSrsjm5Wt4sq2uklJTEfqEx1Ehr5A
        vdnlRMgsIsk/2j+zTMZkoigMulIuRSPPL2pLPrdC0dS0QcGjE4ea7Ie2W6wZbvRBm10xgrHQ3hX
        eWLtfNfRbrNCR4ZI48CS6NmWK
X-Received: by 2002:ae9:d604:: with SMTP id r4mr3995160qkk.401.1633623521167;
        Thu, 07 Oct 2021 09:18:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzISNgoyX8ThhELtimobeSv0obTz8WwchRnJ53hCvPdL8MPEoqR1UNazjrmPhIn7tsohgi8HA==
X-Received: by 2002:ae9:d604:: with SMTP id r4mr3995128qkk.401.1633623520953;
        Thu, 07 Oct 2021 09:18:40 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id h66sm13982024qkc.5.2021.10.07.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:18:40 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:18:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 3/5] mm: hwpoison: refactor refcount check handling
Message-ID: <YV8d3ydgMcTkLwrG@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-4-shy828301@gmail.com>
 <YV4c1dOfctEMnH2s@t490s>
 <CAHbLzkqtaF2iFwg0TmMm_1q+o+-O=CXAAPY2izxL6N=8umX_Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkqtaF2iFwg0TmMm_1q+o+-O=CXAAPY2izxL6N=8umX_Cg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 07:47:20PM -0700, Yang Shi wrote:
> Yeah, it is intentional. Before this change all me_* handlers did
> check refcount even though it was not necessary, for example,
> me_kernel() and me_unknown().

Would you mind add some explanation into the commit message on what kind of
pages dropped the refcount check, and why they can be dropped, when you respin?
Thanks a lot.

-- 
Peter Xu

