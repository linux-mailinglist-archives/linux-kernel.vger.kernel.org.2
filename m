Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665C637BE62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhELNmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhELNmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:42:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:40:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z18so8947360plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f5m0CWPQmgTFVYEYl1GPwVnUgWOnJDMUtav3A2j+jBI=;
        b=mg/UW+MJ0Utsyn6gRQVyJBR2NGW5FzGJYxSJJ6M35L3T6LctNTkvFXS/9ygkg6oGib
         1QmOx8a4SCSdDqFZxKU5D8KWdrIj6xBjNnHKRQmeJdZ2m7xYcbezQWws6i2QLlE7qkDQ
         yIP4vvnUaa7ZwMHTZWplKxhueY4Ucr5+cEKbk9r1MoTio5CPf3CTJK0gprgah13XQLvm
         tmWppykm3HE76BfM12PAXgbgOucr8XjrNS+ZG2GIDifwU9PMb9oXy5AcDQIL318hoWhq
         eTW/K1lMzayfl/dHCLCzachkAze1dGCbGLFNkimLH7A2SOduTrDnnaXdw5ClYSzS6T0Z
         azcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f5m0CWPQmgTFVYEYl1GPwVnUgWOnJDMUtav3A2j+jBI=;
        b=Sd59L5Q9t17y+9okmS0yNdV4f2LFIx9klnHQ0dJLYT0mSKwRF7443d57OWGfWjeS++
         cWMyqt3mabARx+RuT1QeojFHlAvc+Wo4D6EiE3isVVRLjJmyqRkWQFzQeA8DTjbJWOgV
         md2f6K0vkofmGnnzarIMDLz3ywhO6pfOT2uw3omdW+fUI7GyD6/6TL8GC2td2Ssln9CT
         RdMTgLqTs3k2zjxYZ8kOB366UXFnPvltV2TtfTrSBpAzLDhTcUJZyQBnzdsp6G95E0GR
         sokZnwolndxWfrre+D0QuZ5cUrIZDgLJbH/3FJKz/aKlFUtnImf0uNn+ccLiJTYgGB8d
         fjhw==
X-Gm-Message-State: AOAM53060iEUdeBI14SczuQ/hc+eb9u8bNQBiM1fljaib6n7Wv8GPFXY
        NZS4aFsZ5XGauX8YQiLQ1mYP9eh8YBKDaw==
X-Google-Smtp-Source: ABdhPJwGDT0F2mHVIhYeeKXD3gtiBKJG/Sf66E0KdIuZV3A2dj+ZdQwa/zER68ryBhyxs79nyiGO5g==
X-Received: by 2002:a17:90b:3796:: with SMTP id mz22mr10717769pjb.80.1620826853524;
        Wed, 12 May 2021 06:40:53 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 67sm11341pfx.43.2021.05.12.06.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 06:40:53 -0700 (PDT)
Subject: Re: [PATCH] blkdev.h: remove unused codes blk_account_rq
To:     Lin Feng <linf@wangsu.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210512100124.173769-1-linf@wangsu.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d2c079c-8c4c-5e25-e1c2-c17ade5863d6@kernel.dk>
Date:   Wed, 12 May 2021 07:40:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210512100124.173769-1-linf@wangsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 4:01 AM, Lin Feng wrote:
> Last users of blk_account_rq gone with patch commit a1ce35fa49852db
> ("block: remove dead elevator code") and now it gets no caller, it can
> be safely removed.

Applied, thanks.

-- 
Jens Axboe

