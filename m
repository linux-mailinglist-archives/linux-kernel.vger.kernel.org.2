Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A9B438CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 03:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhJYB0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 21:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhJYB0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 21:26:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03257C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:23:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k2-20020a17090ac50200b001a218b956aaso2943471pjt.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=tQv9gvNKRe5PJQMc2A7Fk7rAr/wp9WP9LJ2kxFgnYKA=;
        b=YIFjHGXPc4o/h2EkX0N2PbDOFyLaWWOdoEZjFpJhuu5yADTV2NLNdWlzJOXRuzOTrU
         dSFhJD4BP2apAlpDzL0cN/8XLGRrGvKBiqZE+tOQlSy5W7VY3UgbkI4VyWzbtX7Mc01W
         oQyuwG2yF0pjxh3GhKbFHm+gVzjS65EA1g0hHW+EoFYt8aGMBG1zDD23cDPS+kakq3F6
         YSv5tPDkbWSRsHMdG8bxVpWfWnlNgtGC7XrBtHCRW1R2mP/566YfDrx6KmMipiiYsdwX
         oSg7RKz6Re18SaIfOFSqWAQ9F4d7uE9vhZpkcBiVGhvvJYfy0QQrlxrU8O1geqnyls7o
         PK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=tQv9gvNKRe5PJQMc2A7Fk7rAr/wp9WP9LJ2kxFgnYKA=;
        b=Y65Ybm5fd3sZ4PGCSjoMKGwKRzLCqTkMKe/f6QpIQHXBNYV8giTRgFeqf2jYjDkKlK
         jL3PjHv2e6MmqFXxvgr5xZnLImt7sX9qH4Jujfdc0ccEKrMVWee3tV5aCX9qbjRQNIOn
         sfZPkg0P34agO/9hRMDCNMawpt8EGD+09baoTyMu2aHKr8WbRZSbpjSx2F7i/B1XxAQ1
         cXNid3ZT2tmXZdTDjr41tVZHGAF3JYHWnZNXOp0Tjmj+jyJHEjK0614So5krZa8y/9oJ
         J3aWjFBoeRxQIq4ZRkI0vP5hDIiQ2TWOZnyNfim0oiuWHKvyAWXSgzHtRqRpz03SqIGR
         7Dpg==
X-Gm-Message-State: AOAM533c2s2Tuw7cfWiPsdE7B0V8yHZN/+hVLCFFgyGHtl7ObO6xHpbz
        +WZgnj32TV28FBYoGsIe9YudKMNkvAe5QQ==
X-Google-Smtp-Source: ABdhPJy97c0Pm9bCTK5BOcdqdI+TlWszjzhkUHE/OqjWQkCdvnhRsjDh6mdn1Qd4PtEKP1lIC3Y7vg==
X-Received: by 2002:a17:90b:1a91:: with SMTP id ng17mr16904402pjb.61.1635125019379;
        Sun, 24 Oct 2021 18:23:39 -0700 (PDT)
Received: from ?IPv6:2001:ce8:117:1ad4:f031:a69d:be29:20bb? ([2001:ce8:117:1ad4:f031:a69d:be29:20bb])
        by smtp.gmail.com with ESMTPSA id m28sm14780408pgl.9.2021.10.24.18.23.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 18:23:39 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Toshihide Higashimori <tosihide.0xff@gmail.com>
Message-ID: <b8fe54ab-742e-390a-24aa-43fbbd640806@gmail.com>
Date:   Mon, 25 Oct 2021 10:23:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unscribe

