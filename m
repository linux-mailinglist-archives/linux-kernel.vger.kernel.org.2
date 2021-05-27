Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D77839298C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhE0I1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235481AbhE0I1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622103963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1BsraUe7N57fnB+ujM6T0UDaX7BExCn8Z1KNT+TQMs=;
        b=JfwB1ayr16PH/ez/VDCvbn664b7aApKIC1FE/OnPlHakAJQY7/FDpnTM9w5mhFJJKEtdEa
        7p5OyHbZre4nY5t+CZH3tB4IszdCUSewkPMsuG0asDQo7z4vT0ONCr4utlEgD3J9WIV7Yq
        F/0uobTNizDV5pYM+9ohh1Grl9T8V+o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-GXy9jQ76Mze-TFZtwOUzlQ-1; Thu, 27 May 2021 04:26:00 -0400
X-MC-Unique: GXy9jQ76Mze-TFZtwOUzlQ-1
Received: by mail-ed1-f72.google.com with SMTP id da10-20020a056402176ab029038f0fea1f51so2061895edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S1BsraUe7N57fnB+ujM6T0UDaX7BExCn8Z1KNT+TQMs=;
        b=gAPX9e1/kFkkogebQLVj9cCx562Hcro+D6Sv4cszbFuy9OMjTKi2vHmE59dPjxz2Rf
         9Ud18yeTsCAapcySAZbX9+gya9nSay+Tnartu9b6QbDucd6OnNbTFHHK5UzzVQCK2oUB
         H//u/5PoczeIAL41b/8ETzGTpuF9it12zKNg8thcj9CNCseWgOEZMSF7y8+sqSIOJa8o
         /lOv5s1bLDSEcvOf7VCRqAdH0MI5eE6iRLW71Ucs+5AQezXKh9u31R3wdwIF8DVKnBvr
         V6KsTsnfAPilk8j1+yHkLl0jjtNpDBSw5wAOBddLUUC/mR7SGSm7cBnS54RyiCaA8rGa
         z4cQ==
X-Gm-Message-State: AOAM532S/8x/9T26BF6iLhIguA6zCj4wM7n/7AbGyitfos5Jsk/TTpoT
        tuStmgvl9oGQPMQSQSb8eMunsLkQCC/1Ca59uNaO2aJxmjoDVLsC6AFxihlwdFb3Z1IImwfUDJN
        JNRYxnPY6fWVK3IfQaE0Uerev
X-Received: by 2002:a17:907:20b0:: with SMTP id pw16mr2638528ejb.48.1622103958811;
        Thu, 27 May 2021 01:25:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWG+hZT0e0LFKddR9ePsHZRRuXayqX4XMSKotQzvDWjtAN99eVYS0eWjYQsi/+6L6jbovDOA==
X-Received: by 2002:a17:907:20b0:: with SMTP id pw16mr2638515ejb.48.1622103958612;
        Thu, 27 May 2021 01:25:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id nd36sm614722ejc.21.2021.05.27.01.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 01:25:58 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the hid tree
To:     Jiri Kosina <jikos@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210527152631.1e70fba2@canb.auug.org.au>
 <nycvar.YFH.7.76.2105271012430.28378@cbobk.fhfr.pm>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e5ee42f7-b0eb-40c7-e54f-8e16e8b97b68@redhat.com>
Date:   Thu, 27 May 2021 10:25:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2105271012430.28378@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/27/21 10:14 AM, Jiri Kosina wrote:
> On Thu, 27 May 2021, Stephen Rothwell wrote:
> 
>> After merging the hid tree, today's linux-next build (x86_64
>> modules_install (on an allmodconfig build)) failed like this:
>>
>> depmod: ERROR: Cycle detected: hid -> usbhid -> hid
>> depmod: ERROR: Found 2 modules in dependency cycles!
>>
>> I could not easily figure out what caused this (it may not be the hid
>> tree, but probably is), so all I could do was leave it broken.
> 
> This is caused by Hans' patches (CCed). I will be dropping those today, as 
> the proper fix needs a bit more of rework.

Ack, sorry about the trouble these patches are causing.

Regards,

Hans

