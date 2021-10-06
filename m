Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0619C423CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhJFLhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhJFLhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:37:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4060CC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 04:35:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v25so7852758wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WlB+aQwesSqg+PcbUJ65iZtpYtFLGZhjloxXmDYdamI=;
        b=L2cB28Z0wz5JHhrTTsd6YlPd2Blpu9lFVOJC8to1DQTlK3kM6hhcyJVTp/k3dTx2dN
         /KqMwAlC+HrNAYlnL0fugxZXs+WAIT149hLimQ0fogDazUC3BvCMiRctmkPbF7SqNTyY
         9jKVm/8Ncj1LM7k9kWAO2dt9TmW5UrGdZnOfJDA8b38TCDDzzLnl+679dnFEfQ2gAUY3
         SkyqpFOmkNOKwyTLzX5YMDZuDE5454Rk5/UIZOu3740JnBGWYauo54MZvkB6rQumBp3Y
         cnoDmi0ok14Uez/7gp9D0zEnO/DE4zlkNIWamTa05HbrM11NaoxAmFexZTQOYSA9mQUk
         yFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WlB+aQwesSqg+PcbUJ65iZtpYtFLGZhjloxXmDYdamI=;
        b=KuLUOcdPoW8QFsC7p0XYXIw2Nzn9M1y/Aug2bKlsqYXy4i+9PRP+xDJvTE33MewR12
         NBfFJHf/IOG0eqkvaSyWMdeCZq9aZyLc+LF1PgRvT91yyVnwvYa+Vr9/58ZmR6bmTCEr
         ep3PZwvVdPG5HB+vjjfSSeWnUWV+8yjVYN/gGq/18sorCauv76UrzhWtJgH9GAikhtf9
         6jcWx6Bie+s4AcZO2sCXT1Noexx48bUu2EI6+2yULhIf8w83DZg5wEBkya7Zxpexq2Ar
         zQwS+PKjLx1WoWGbBUGFbqN2bKw7cUr13Gr7QDmKxYM9i8OczKDTXQrge3qk1cCpXQB7
         tFvQ==
X-Gm-Message-State: AOAM531kQKFXoh63j5GoXrjHfJKOaVViP2bn1oHJhWsSOKl85vaqZB4P
        3Ukuus7kx0JFm1XixV2ZEdFVzw==
X-Google-Smtp-Source: ABdhPJx4kB+4pSHbo38S/Hyxgkv3G5HzJVBV0fElyQQUYmWqrIKgrK7SOiuo6C3zNW2p6gI+eZbByQ==
X-Received: by 2002:a1c:43c3:: with SMTP id q186mr9058705wma.143.1633520121547;
        Wed, 06 Oct 2021 04:35:21 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:378e:f074:3bc9:383c])
        by smtp.gmail.com with ESMTPSA id n186sm5079756wme.31.2021.10.06.04.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 04:35:20 -0700 (PDT)
Date:   Wed, 6 Oct 2021 13:35:15 +0200
From:   Marco Elver <elver@google.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 5/5] kasan: Extend KASAN mode kernel parameter
Message-ID: <YV2J8/i7C/FYf4F1@elver.google.com>
References: <20211004202253.27857-1-vincenzo.frascino@arm.com>
 <20211004202253.27857-6-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004202253.27857-6-vincenzo.frascino@arm.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:22PM +0100, Vincenzo Frascino wrote:
[...]
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
>  extern bool kasan_flag_async __ro_after_init;
> +extern bool kasan_flag_asymm __ro_after_init;
>  
>  static inline bool kasan_stack_collection_enabled(void)
>  {
>  	return static_branch_unlikely(&kasan_flag_stacktrace);
>  }
>  
> -static inline bool kasan_async_mode_enabled(void)
> +static inline bool kasan_async_fault_possible(void)
>  {
> -	return kasan_flag_async;
> +	return kasan_flag_async | kasan_flag_asymm;
> +}
> +
> +static inline bool kasan_sync_fault_possible(void)
> +{
> +	return !kasan_flag_async | kasan_flag_asymm;
>  }

Is the choice of bit-wise OR a typo? Because this should probably have
been logical OR. In this case, functionally it shouldn't matter, but is
unusual style.
