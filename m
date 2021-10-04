Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8F420599
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 07:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhJDFj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 01:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhJDFjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 01:39:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB26C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 22:38:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b22so10337314pls.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 22:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tq0l7s5aqcsatZHITso0miQL7uKU181XjXi2aKB8ehU=;
        b=Zk1VBVl9gn3/Clp1c/oV/PSxJE2LF4Zh2QH1hm2MlMcrn5SsuYPw0piHD8NlcnNcnT
         AmE1yx1myRjmio/kMypE9oWVr6Km3lc9BDWPj7E7cEgZZQ6ZRf/UpxJG+/sjK2aSmBg2
         yDzfFreydseFy6mlKpgDPXUhkl7OyM0nnvJ6haAdPB3bJghAT3OFTteQm9JesbDbd+gE
         zVBBuU+gOFlr+BPXA0DKkraSyzUhctSHpN8ziPMOb1SUiFsDpcv4G+vyTDHEPFwQmm/A
         ajtXvLyrjdor6xfQ/4F87MOSdyU5q4L7hNjChF/fAZLlreXzUlXJrSArDvxed2L1Gbew
         xgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tq0l7s5aqcsatZHITso0miQL7uKU181XjXi2aKB8ehU=;
        b=SaWld/SpPPim/h844Rs7f2e4WYfuGdJCbrHwmht+P+E/4E2jhLIOqPE7Ebc1v7vMX+
         8y1PHyAdBB0mTejeVp9+tyq0wniKvACtiqGDtfXc1U4HyQPG22WcPvUTg1QHWa8XYiPs
         XKlvlpfd4Qf0hp/ycE0zUT23RCaHT2pKxk4g957AdpjsRF+r6fdD/YlUQW7OtVZUWnaT
         PqBUEHFu4oONVGhFk3ZkUQBnn59zVcTmgY5q+gt8Hi/RJ/Ysf/0twQQlmfLTH2tUJQvP
         mUcdDXsMPc7+r63CmcuF5aInpMzjv51fV17bXWggjEIGcomsKEmuPJsbNaXk4FkfRtMu
         syDg==
X-Gm-Message-State: AOAM530x6Yo3XmE7UGJ0q3XOduz1evDlcEJb5OXnJzzw/+ndxZwhocJA
        HIAjGcC9wPxiFt9ar2jyASk=
X-Google-Smtp-Source: ABdhPJyWktXlDh6Qa4SafhNJ38qGmR+NW9ts9P+y3ZqUilfW8vSLm0xpqVqhIMa1MEV1w6u9aGcuAg==
X-Received: by 2002:a17:902:d707:b0:13d:bbe8:bcff with SMTP id w7-20020a170902d70700b0013dbbe8bcffmr22637156ply.75.1633325886307;
        Sun, 03 Oct 2021 22:38:06 -0700 (PDT)
Received: from linux.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id i27sm12585289pfq.184.2021.10.03.22.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 22:38:06 -0700 (PDT)
Date:   Mon, 4 Oct 2021 05:38:02 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH] mm, slab: Reduce space complexity of alien_cache
 using rbtree
Message-ID: <20211004053802.GA2575@linux.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211003051750.8296-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003051750.8296-1-42.hyeyoo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 05:17:50AM +0000, Hyeonggon Yoo wrote:
> +	for (i = 0; i < alc_ptr->capacity; i++) {
> +		alc_ptr->pool[i] = kmalloc_node(sizeof(struct alien_object), gfp, node);
> +		if (!alc_ptr->pool) {

There is mistake - the condition is (!alc_ptr->pool[i]).

> +			for (i = i - 1; i >= 0; i--)
> +				kfree(alc_ptr->pool[i]);
> +			kfree(alc_ptr->pool);
>  			kfree(alc_ptr);
>  			return NULL;
>  		}
>  	}

Anyway, I want to hear other's opinions.
Is this trade-off sounds affordable to you?
