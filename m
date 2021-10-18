Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C1432523
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhJRRi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhJRRi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:38:26 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524EC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:36:15 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z69so14094217iof.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rOtObZrff10JQnf9tPidEThLrX8L6t1TEMTSXFa90+s=;
        b=fie39H7weO6maR9WBLQnCBKtpfhxpmPTdprVNS33JNTs3wtn/qRrpuO9wmh3D17IFg
         TW70gkKYY5q/yibWQMvcsBm/ShaDPer5lx9yTuDSMkJlkn2pBZ/Wgxm1j8bo1xPzKlVy
         SFYA3O6oiHLFwLCb0IgxEORr6kn2nOa+PRZQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rOtObZrff10JQnf9tPidEThLrX8L6t1TEMTSXFa90+s=;
        b=QfxXk4bt3W1hjwA3iXRzAS54x3ChqjYzM2JXSV1pRXLE0N4HmMmODRc+0RIUSQVmFx
         Yzj8i3/gZ+LjNdM6h2yCRbUDeyEbdFYJfGcdofoLsxXwbohv7owgfJs7vwHY/LFpdZer
         rS+/HSddHtRUm1CY26vhRr5j70EM9zqd1JW10McQnQGN+h/4RTwCSaStIrPMZpnATxcW
         Rw4fkGEdkyZifBQFbhgAoDZFtcBrqq5uuLJTYGymHnl4Brw34/cXe5OmNV2A344PTEXG
         z3KB5sD3UjkD2dVUZqv6EpVmCE506oyN2xQxZaJVr7Z1H+K3Za3+HHsNNOd2IX+1JNTM
         n1YQ==
X-Gm-Message-State: AOAM530IGbizNqQYyGNndxwtDZQhZu2irM/0LFqZsOPwJCDfyZ6FWf4a
        58pE2uSJGZbuYPLNb3PK/FvUfzPeo3qXvQ==
X-Google-Smtp-Source: ABdhPJzQGm3VnaxzFWaDhKJGwR2S7m3WQZJqm7y/EWtrh7jk3VdiTnqgGazVZ3lhElpn1KdQw+X/6g==
X-Received: by 2002:a02:ad05:: with SMTP id s5mr811099jan.65.1634578574850;
        Mon, 18 Oct 2021 10:36:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r4sm3883991iov.25.2021.10.18.10.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 10:36:14 -0700 (PDT)
Subject: Re: [PATCH] module: fix validate_section_offset() overflow bug on
 64-bit
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211015205741.38283-1-skhan@linuxfoundation.org>
 <20211015205741.38283-2-skhan@linuxfoundation.org>
 <YWnvN7jHdWHl/05D@bombadil.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <42f46af4-4698-f235-9d1a-749774b5cee8@linuxfoundation.org>
Date:   Mon, 18 Oct 2021 11:36:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YWnvN7jHdWHl/05D@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 3:14 PM, Luis Chamberlain wrote:
> On Fri, Oct 15, 2021 at 02:57:41PM -0600, Shuah Khan wrote:
>> validate_section_offset() uses unsigned long local variable to
>> add/store shdr->sh_offset and shdr->sh_size on all platforms.
>> unsigned long is too short when sh_offset is Elf64_Off which
>> would be the case on 64bit ELF headers.
>>
>> Fix the overflow problem using the right size local variable when
>> CONFIG_64BIT is defined.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Thanks for doing this! I put this through the 0-day grinder.
> 
> In the meantime, since this talks about a fix, can the commit log be a
> bit more descriptive about the impact of not applying the fix? In what
> situation would not having this patch applied create an issue? Is this
> theoretical or can an issue really happen. Has an issue gone
> undiscovered for a while, and if so what could the consequences
> have been all along?
> 

I found this when I was adding an error message to print the offset and
size.

> And it would seem this issue was found through code inspection, not
> through a real bug, correct? If this can be clarified on the commit log
> as well that would be great!
> 

Sent v2 with updated commit log.

thanks,
-- Shuah
