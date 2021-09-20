Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA741162A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbhITN6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbhITN6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:58:35 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07E6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:57:08 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id a14so3335487qvb.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oxidecomputer.com; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=ixZsglSnnYNu74IDkiQfs+ZYBeCsWtXcrporrs7/SeM=;
        b=LcXgEutnZZsUMddw6zMlMkkyFElxHwQdd4kdkA2r8fYQgiBTfRcSDivn+yJJcTKVpP
         dyL1uP1LS0jP71ax77Hdw4AmNyAJ14G3OgJ4CHWyjnP8xt5PeLJEuo+s+6lJLkikCC2b
         gXpzvFWSSWOHkUa1LmC1mywcWdHEFnfAnsZ6sebDfXH0cX/BzrzIQyvhVajOkjihrpOU
         c5f/tt46ThS1Qr2FIx3uEUJ3PQhR2bGV8CsBwNfAa3P53G3hD1gQDaPJ8b8PqeWxhXI0
         MrBIBhZelx4yo3/6Vx+0G0A696rWB36qQQRxA/Nj0ihUvmJaRYJpElamnEqg+nXCOzEg
         WAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=ixZsglSnnYNu74IDkiQfs+ZYBeCsWtXcrporrs7/SeM=;
        b=cy7pmJNXzKnXYvgK3KwKRR0KtthdQ4zs7XhYsIdG4K7B1fNwhUUCyk9dtvXoCeZ+WX
         VyiIoXbsEsE28Vgl7pafkTHb09eIaXbk1ljcaqdxcAlpGMqLq5kD5O9AiKUprCiSYigH
         EDYuPzyM/ouPhAyOxYfSItOmpTK8FOT6XGrskwa8w2uAX0LzGBI4xnPu6/U03HqJFTTr
         JOsrJes9zf9DxJ6kg5EvseUSZINxks6hKj2gdVTJbYEPZxl7UR7fUtEB+Hpz0HgyY7wx
         h+rth+2cY+YL1I673SSyQAAl6SNWLpvGxrshSLd1/ZJ4RXF7UW45XH97OM5VmsDQEvPj
         C06g==
X-Gm-Message-State: AOAM5306SFLUN8iiLezALSU5V5LYgNO8bIGoYNXm6lWLgfa3FqWG4hnm
        ea77u6YwIqNQIic0+DL2+e9QicLQkLXKX+X2
X-Google-Smtp-Source: ABdhPJyhKSVZyvN6bYMYr94Ja8VU5RrQx6X6PnbykN1riYPslBcV6O6Nin9/igPtsrTiFBChMwN6xA==
X-Received: by 2002:ad4:4765:: with SMTP id d5mr16092538qvx.51.1632146227568;
        Mon, 20 Sep 2021 06:57:07 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id bi10sm7048934qkb.36.2021.09.20.06.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 06:57:06 -0700 (PDT)
Message-ID: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com>
Date:   Mon, 20 Sep 2021 09:57:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
Cc:     "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>
From:   Laura Abbott <laura@oxidecomputer.com>
Subject: IMPORTANT: CIVS opt-in for Technical Advisory Board voting
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As in the past we are using CIVS (https://civs1.civs.us/) for voting.
This year you need to explicitly opt-in to vote in a private poll. This
is a change on the CIVS end and was probably added due to concerns about
spam/abuse of the service.

Please opt-in at https://civs1.civs.us/cgi-bin/opt_in.pl

If you have any questions please feel free to e-mail
tab-elections@lists.linuxfoundation.org

Thanks,
Laura
