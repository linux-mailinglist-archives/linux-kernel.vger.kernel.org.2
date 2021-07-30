Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7C3DB1F1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 05:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhG3D14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 23:27:56 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:40654 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhG3D1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 23:27:54 -0400
Received: by mail-pl1-f178.google.com with SMTP id c16so9394502plh.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 20:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pLzkFVIMJgN4oELkzDMo9eJP8ZgAY2dOjJXshTg16Vo=;
        b=TpoM4GKB/brEKb1+lLcNHpdj1Ekhxh0jcKyx6bTIBKgSun9uu6ifKe46mmJCgnM57N
         pfgo5kCNZmo4LE1HGQpm3yhUv6yf7RNh+oVhqrHrADmXUFqCZpEv7WcHm0pqi6xiDU9a
         mMuHLcLQnaRsRKuXNsqAjfmCDID2fsxEeErSdT3cKbS2miCaaCX3IAn0WLU2Ls3WnztM
         s1BbGqwSmfc29aT13jJZoOj7lG0dO9MU5KskuY7J2USB3ozJ4BoSop2ekneUUnkTqcGf
         a17rgAf2l6oBmNAIN9St1YwZLpw3duSR/0PVQiM46Qnr8+q5GAR5UjHIzgNTFs3oVDOp
         wsrw==
X-Gm-Message-State: AOAM533lcg6luU4xEjwIcwg7uxVblcDm+tEEyXFFzbPbYIgLgz4ktydI
        JbVx3RCSpZY3rOjLuyDfuPM=
X-Google-Smtp-Source: ABdhPJz6tYtSMfqpxRcrb2Fpy416ldpPlVgXQOn4w4VuOuvgNzGf66bUvDEMH2cosojLU7Ctsl3rYQ==
X-Received: by 2002:a17:90a:4093:: with SMTP id l19mr748578pjg.118.1627615668918;
        Thu, 29 Jul 2021 20:27:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3f66:df55:a341:f79d? ([2601:647:4000:d7:3f66:df55:a341:f79d])
        by smtp.gmail.com with ESMTPSA id v13sm315242pja.44.2021.07.29.20.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 20:27:48 -0700 (PDT)
Subject: Re: bisected: 5befc7c26e nvme impl non-mdts gives smartd error log
 entries
To:     koos vriezen <koos.vriezen@gmail.com>,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <CAGCbPWR7dk7fWxMGQW2ygSEbgPLbfaQiiVb2J6Tczdt_oOCheg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <342725c8-f733-d2ca-13f3-ff5f9cba09e7@acm.org>
Date:   Thu, 29 Jul 2021 20:27:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGCbPWR7dk7fWxMGQW2ygSEbgPLbfaQiiVb2J6Tczdt_oOCheg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 2:18 AM, koos vriezen wrote:
> On my XPS 13 9380 I get local mails with content [ ... ]

Hi Koos,

Please post NVMe-related issue on the NVMe mailing list
(linux-nvme@lists.infradead.org).

Thanks,

Bart.
