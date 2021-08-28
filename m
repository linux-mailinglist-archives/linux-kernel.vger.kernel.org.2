Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BA93FA73B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhH1Sub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhH1SuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 14:50:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE76C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 11:49:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c8so9207545lfi.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=h0rC4E3eFAssZyenmgepnwP9EKZAhinMJXxfmnOgSEoKODfgUdU+yRbPZK61Rr+udv
         t2psYZIkPZQjVZjMT6v92QDLA/pubdEhaKUd8wtzggWbkXkQeeXjvEMixpCSZ7rWhTxW
         rggS7SqeViKas2D9ud9CrEnkmIaHU52iyCf1uwhhIWWTQu14hfzPbnEuD8pe11f8IKVy
         fY4RXaHEjNunJg16ilERSi6qcPYVHVjC/ChxwI/hgQMCd5OamPDWHo83LlRpF74hBOTI
         jhZ1d9jDVFXk/ZfCWCe4aoFsl5PYz7VnaeEvPXTIwP6T2fBwYgM+bcKZE/kepabh3ouN
         MwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=gQ7WuucxTc8FB7Wsffaq6+MjNQDg6X9eQ0vYsuo5FY5oHGlJVI+kpAhei85EfMhDJ0
         vIVslOSb3ZC86FD9wonQjx1oCivLHcY64Z4vQ4yDtLQlYGz+lJQFip5WpJgpUOdUMSc9
         ingztRJ7Rrk+mhCdXrrNN652pE63u/IdPEAFAZaVXuaqr6sZZhbJy0JQISNTssXByOIJ
         JjmAAGCjhIvhTBa+fDW/OCfrU4BBdyilKx8yazH49RxVQ6YBI/0KfSS06RNu+wWkE/c0
         997nliYw2eInXpqqApkmAe4in5BNoKxUvAMioj6Na4k5I2eO5DA9CbJ7EHizXXZ07gyx
         adyA==
X-Gm-Message-State: AOAM530z0HSnQ9OisNnyEgpw9smZXZksw69N6/NlHeg8JkgEPnX8cNxs
        96w0RN0MZkoiYRBqCcLTcjBmSwr/7SkffQ==
X-Google-Smtp-Source: ABdhPJzNS8tpiA5imkCzxE+TouAsjNGXvwUFRBAQEoqEBUHxDMTj3wywpauX2E8/Ylu7blzhdb+HmA==
X-Received: by 2002:a05:6512:3694:: with SMTP id d20mr10760849lfs.556.1630176571944;
        Sat, 28 Aug 2021 11:49:31 -0700 (PDT)
Received: from [192.168.1.218] (78-63-10-115.static.zebra.lt. [78.63.10.115])
        by smtp.gmail.com with ESMTPSA id 6sm1142442lje.22.2021.08.28.11.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 11:49:31 -0700 (PDT)
To:     aldas60@gmail.com
Cc:     devel@driverdev.osuosl.org, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20210827163203.4100-1-aldas60@gmail.com>
Subject: Re: [PATCH] staging: vt6656: Remove filenames in files
From:   =?UTF-8?B?QWxkYXMgVGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>
Message-ID: <7bc3eacd-6c0f-2b66-226f-ae1747c0f07f@gmail.com>
Date:   Sat, 28 Aug 2021 21:49:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827163203.4100-1-aldas60@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


