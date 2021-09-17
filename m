Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B82410034
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbhIQUIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:08:51 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:33439 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbhIQUIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:08:48 -0400
Received: by mail-lf1-f48.google.com with SMTP id y28so36642795lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=N7xe1MVTQpkG9cEW7D9KE/1zftBQkfOXG7Edz9i11jo=;
        b=s4glgaEvBEqj9gRyr/WW9U6X32CMUbCUp0aLoZv1j+lm9S1SYrYuHd0giBFAWR9MFZ
         1FEBlzNZm5U1HjeznqHC3Ahs1bfTAttYv9igsUYzTbTuf3T6IgNI6tUsvsz43ulDJbo5
         v0hDrjW9A88AKASwa6GsGuuxkhlu/9audbYX67WrbThK64/gfRD5kHdfLw9NfuXrv7RP
         m9HDk1lBStDA0zCK+eMSQFQXJ0Bp21n45GGGJcULuIo+wI0ze9dgwpnh4O2z1PpMf3oV
         CyUtkHQMA3Vgh2zJI2s2rwiceAAego2JfrnAiixA3eizv3ZpIHIBFq7v41o4oPAgMP4p
         cDFA==
X-Gm-Message-State: AOAM533FeMJROqyzgvm2SiDSEQ6rTe4pedHFEKE6SQPr7zJnyQ3Olc0T
        h62ZWnuadD9guy99LoT/b7uutF+kSC8=
X-Google-Smtp-Source: ABdhPJyX58P6qu2xuZcbu2vkUZD2V9mjMMOHlSVH7TTD53EX2DDG4H/IFG5gtp6uk0LA2bZ3iqMREg==
X-Received: by 2002:a2e:6a03:: with SMTP id f3mr10754662ljc.487.1631909244576;
        Fri, 17 Sep 2021 13:07:24 -0700 (PDT)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id f4sm600456lfr.151.2021.09.17.13.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 13:07:24 -0700 (PDT)
Message-ID: <d72f55fc-bbe2-b02d-0a90-ad6aaef8810e@linux.com>
Date:   Fri, 17 Sep 2021 23:07:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>
From:   Denis Efremov <efremov@linux.com>
Subject: Unloading a module with a function which is used by a static call
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not sure, but is it intentional that we don't increase a module refcounter
when we call static_call_update()? Let's imagine that:

we load "Module A" with:
  void fire_a(...) {...}
  DEFINE_STATIC_CALL(fire, fire_a);
  EXPORT_STATIC_CALL_GPL(fire);
  static_call(fire)(); // from time-to-time
and load "Module B" that:
  void fire_b(...) {...}
  static_call_update(fire, &fire_b);

and then unload "Module B" without updating back "fire" to "fire_a".
"Module A" will try to call "fire_b" and will crash the kernel or
call something else instead. Maybe pointing static call to a default
value in static_call_del_module() with a WARN can be used instead
of module_get().

I reproduced this scenario here:
https://github.com/evdenis/static_calls_unload_test

Regards,
Denis Efremov
