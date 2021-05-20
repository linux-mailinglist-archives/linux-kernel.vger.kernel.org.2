Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64C338AFFD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhETNbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231733AbhETNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621517412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eWdIomCLFx44iRm8WuQiWInpjpi2ZWHex+bxzF8XYn8=;
        b=XCibdSh0n7NDX6PftY6lDpawUgJdvmuVNWzp4lqB3SYwyNGHDV00+68yRdmZvlQRWm3pnS
        A5I5KN9RRYvPMEkY7xlCjg/I2OVWSuL9+kfR02sa7/1xutHLDpeeisCOCeldTdvx6zti4l
        DMBFULs+gbF7SUAfB4izQ8rxr5pwML8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-kDSsFFbWPoyjlK8INQP0VA-1; Thu, 20 May 2021 09:30:10 -0400
X-MC-Unique: kDSsFFbWPoyjlK8INQP0VA-1
Received: by mail-wm1-f69.google.com with SMTP id z1-20020a1c7e010000b0290179806d11d4so1232884wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWdIomCLFx44iRm8WuQiWInpjpi2ZWHex+bxzF8XYn8=;
        b=AGHg8FvI6zyk0EXnNiNwSbl2Rjs7rKbPejhRzo8nkCbZUA0TRKpeouesWR2JZ327dW
         Ii7UkhCx7pbcMcA2eaeXXy0Re36VgIi15kg0B6gjZXOT09OlUZXfhxO+Lsy41xzExA9y
         DnoSott/ZijdJ9NLFSqdKcu9O7Ialn/J01E+6Gu3EP6OhCN65ZZk7X6YI2NbE5a+PyKB
         Zov1qhLEPLi2X4rb1LxyojYBd9U8SQcTk5X2gKC4CUmEBwZtgdez0ckleyUVIJprA9I+
         q2qRnZYSQdBVX4bravPOeADlcSc/hRhaPQ83cgtGE14hCDP1erVFuU1gJAZJA8wSpSZC
         I7ug==
X-Gm-Message-State: AOAM530FTVDlLQgIFwwUAm97HJiqlFwbPz9b0iVhCXZTpEMPdKSlDeQi
        MsL0H4qy0N+JvYOQRgQaamBbFLRY7sJaeKVIhjhVkizBfcXsh8tliXVlOCWVg+HrFzw9MjLP/Lp
        ejKAVRBKT009+eVsFhuyn0Ik=
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr4340254wrq.65.1621517409126;
        Thu, 20 May 2021 06:30:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9G9/e2mpDktiTR7r60CiZtDUSC3pQ+rjYtpM805ZR8yorcH+q65chSFTqP6ZokgQhp3bvjQ==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr4340240wrq.65.1621517408969;
        Thu, 20 May 2021 06:30:08 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o129sm9391914wmo.22.2021.05.20.06.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:30:08 -0700 (PDT)
Date:   Thu, 20 May 2021 14:30:07 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        mhocko@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
Message-ID: <20210520133007.ybkc7ft5g5b3d7ds@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <YKVn69o1UizH0kJD@casper.infradead.org>
 <20210519201743.3260890-1-atomlin@redhat.com>
 <20210519213455.97ff95f0124b4120787f8314@linux-foundation.org>
 <9b11dcd8-bc3b-aae9-feb1-43543bf9e22f@suse.cz>
 <20210520114257.huqhkqsdrhohn3u5@ava.usersys.com>
 <YKZObDpduqwWi/Zm@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKZObDpduqwWi/Zm@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew,

On Thu 2021-05-20 12:56 +0100, Matthew Wilcox wrote:
> While this is true, it's not really answering Andrew's question.
> What we want as part of the commit message is something like:
> 
> "A customer experienced a low memory situation and sent their task a
> fatal signal.  Instead of dying promptly, it looped in the page
> allocator failing to make progress because ..."

Apologies, I did not understand - I will follow up with a v4.


Kind regards,

-- 
Aaron Tomlin

