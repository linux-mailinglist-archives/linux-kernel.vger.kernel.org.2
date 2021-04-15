Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4757836072E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhDOKc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOKc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:32:57 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7B3C061574;
        Thu, 15 Apr 2021 03:32:32 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lWzIU-0003GZ-AA; Thu, 15 Apr 2021 12:32:30 +0200
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        w4v3 <vv4v3@protonmail.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <vaWPnw1Txo_MD5Sf-BnMmq3pBTkITza0W5p_jAi8JIy3hBAbCsKPXZ5g5IHKYGqK6zLjzUNgJ59xMCHvhREBUq6Vc1105b8yCIVDgaPABqE=@protonmail.com>
 <dff6badf-58f5-98c8-871c-94d901ac6919@leemhuis.info>
 <wqM80O49houE3ZJHpxjcrNxijZ_h9pMjxZU2OCL-ZpsdwMhIVFcGXZb9qe93r2AY0qd0dB-94ZVQaF-Xb-i-zqX5DIO5S4C6UTBpVkxvszA=@protonmail.com>
 <CAJZ5v0hX2StQVttAciHYH-urUH+Hi92z9z2ZbcNgQPt0E2Jpwg@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: "Reporting issues" document feedback
Message-ID: <b1cbdc62-85a8-93f6-0158-1a905f3986da@leemhuis.info>
Date:   Thu, 15 Apr 2021 12:32:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hX2StQVttAciHYH-urUH+Hi92z9z2ZbcNgQPt0E2Jpwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1618482754;2913ccfc;
X-HE-SMSGID: 1lWzIU-0003GZ-AA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.21 15:42, Rafael J. Wysocki wrote:
> On Wed, Apr 14, 2021 at 3:22 PM w4v3 <vv4v3@protonmail.com> wrote:
>>> Links to your bug report and the thread on the mailing list would have
>>> helped here to understand better what's going on, but whatever, they are
>>> not that important.
>> Here you go: https://bugzilla.kernel.org/show_bug.cgi?id=212643
>> https://marc.info/?l=linux-acpi&m=161824910030600&w=2

BTW: thx!

>>> But it should, otherwise the subsystem should remove the line starting
>>> with B: ("bugs:" in the webview).
>>>
>>> Rafael might be able to clarify things.
>>
>>> But afais it's appropriate there is a B: line: just a few weeks ago I
>>> took a quick look at bugzilla and ACPI bugs in particular, and back then
>>> most of the bug reports there got handled by the maintainers. That's why
>>> I assume you were just unlucky and your report fall through the cracks
>>> (but obviously I might be wrong here). And maybe your report even did
>>> help: the developer that fixed the issue might have seen both the bug
>>> entry and the mailed report, but simply forget to close the former.
>>
>> Good to know. It does seem like many recent ACPI bug reports on bugzilla
>> have been processed by maintainers. Maybe it is the ACPI-subcomponent I
>> chose for the bug: in Config-Tables, only two other bugs were submitted
>> and they did not attract comments. Anyways, I understand now that it's
>> not an issue with the document so thanks for forwarding it to Rafael.
> 
> As a rule, ACPI bugs submitted through the BZ are processed by the
> ACPI team (not necessarily by me in person, though), but the response
> time may vary, so it's better to report urgent issues by sending
> e-mail to linux-acpi@vger.kernel.org.

Rafael, thx for clarifying. And what you wrote is likely the case for
subsystems as well, so I submitted a patch to mentioned that in
reporting-issues.rst:

https://lore.kernel.org/linux-doc/dd13f10c30e79e550215e53a8103406daec4e593.1618482489.git.linux@leemhuis.info/

Thx everyone! Ciao, Thorsten
