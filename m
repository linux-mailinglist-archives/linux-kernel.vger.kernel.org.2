Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0917E3BE6C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhGGLA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:00:58 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:33445 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhGGLA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:00:57 -0400
Received: by mail-ed1-f42.google.com with SMTP id eb14so2892896edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 03:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6zKc5bM/j/Saim3WcJ7XMsv777ylB6DzjZT8Xkvqlo8=;
        b=YBlY3OA1w08YgEmpoKyAq+3r1IVUPvQV/nZpGveTbCN7X3dTfTXCgdulxDOouWDNtz
         ttqw5zkSDlW5w1xK49GC0+lG1u3Pcmj4yH/VjsQgIPqafMfqjwr+mU4OtVItvj7DZmEo
         JPsRrusjIGXlWGyfNvPtqHTmuiKHrOvVSWGjA1i1yL00cmd1L0+Ko8LyVj6WVIFSCPzM
         8ZpvcdcOmsOtSYVY2VEEq0bj7ceaKU1McIA5tozxJoreQfaTMEdFWhzbGX4jLv4QTk8E
         RaHolZY9gHdB9GxS0RAs2pAl8S213URciOVvT6cYmUl3d8pJlPjEEpdmf90IFmci/orJ
         FpOA==
X-Gm-Message-State: AOAM533FzsMqye1YMQ0vOupzcfNHSyA1s115mjh7hQwZAnbN+MDEOlCJ
        EL0IWgrLGxPo91o3FCdselam8ixIZuprVQ==
X-Google-Smtp-Source: ABdhPJw9AWx/zVkQP7+TWOppO1SN41FBH7XT10N9Y4mW5X2FTCcM1e3yMvvdcWiMqnnW+M23v3zplQ==
X-Received: by 2002:a05:6402:1001:: with SMTP id c1mr29109250edu.26.1625655495857;
        Wed, 07 Jul 2021 03:58:15 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h8sm7057430ejj.22.2021.07.07.03.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 03:58:15 -0700 (PDT)
Subject: Re: [PATCH v2] xen/hvc: replace BUG_ON() with negative return value
To:     Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210707091045.460-1-jgross@suse.com>
 <9e45c5f8-0ac0-e1bb-4703-838679285e80@suse.com>
 <dd32b09b-7345-664b-165d-dfb30c285448@suse.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <b38eddf2-52af-3fa1-9cc0-681c094e327f@kernel.org>
Date:   Wed, 7 Jul 2021 12:58:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <dd32b09b-7345-664b-165d-dfb30c285448@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 07. 21, 12:40, Juergen Gross wrote:
>> And btw, since I've got puzzled by the linuxppc-dev@ in the recipients
>> list, I did look up relevant entries in ./MAINTAINERS. Shouldn't the
>> file be part of "XEN HYPERVISOR INTERFACE"?
> 
> I wouldn't mind. Greg, Jiri, what do you think?

/me concurs.

thanks,
-- 
js
suse labs
