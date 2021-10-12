Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E62942AC19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhJLSiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbhJLSiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:38:05 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762D2C061765
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:35:20 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id i11so40019ila.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f5Yq+I2CP/Ps/1laaridV03Q4v98yY+V05yeOfFrM3Q=;
        b=GgWJ7P70tJVCTr+ittFKd31/RLQJFNZqfpoqVkBc3X9cdVh84Nsp9owgrfRh+IKIjx
         flBGypHb7TFlnNiIXbgqdAAT4S4xtCgqf1DN/uHRpquAnSE9u0yW2MTvdDPqgtC7IUth
         TyzMU/C3o4/BZ4gN3VQ3rNqeih1f/Y6AkuY6NhA9PxmHNAstg8AroZiXibXgw91JpGB6
         61p26KK9nSheTQhkEUo7lo/fb/xzULF2Uwem5WVCfO/9nPihxGKm3z0ETVmC1mFTKpk2
         smZoJrgdDfsRBotL8TNrmHy7V7Lurlwdgu54cMzjaILOwIqMW+wMBvS6f4LmBzFF554x
         D+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f5Yq+I2CP/Ps/1laaridV03Q4v98yY+V05yeOfFrM3Q=;
        b=g02Mpi5drjCDB43wob9LcDKcWalbDD3kIdeol05s7EEBtZbW44MdVv0ik8FvOUOa9e
         JcZMKBq808q7UhkbZxb3TQcmI1hW4m/8nCzIyW2OesBoLGzalTc5HYnRUdm1fSLm2VEa
         ZrMBnlhgScJaadt6zk7f6Y6gdHfK1pTBZ8DeiaQ4mKJT93rCXJY3c9HXKSzL+HzJN1sq
         U1GLuV3RyitdHZwusJeiqBsu17TnkDGt1htVkMzPFHNtPVI3y0CazNrN3WT9sSS4izli
         /JnWhT28kEpIqe0QzzUawdH9fzpYyaNovkXY00GVz9W8ztux2fNijvwzFxijKXDsL1Ib
         4KZg==
X-Gm-Message-State: AOAM530N0Bmqy5RSKuCgn3MrLVqt4p9H8aWONu6Lfq4rl0sIfdovYuD6
        k0+pTaTHerXQ33kRE7rA8zqqVWiZ5nQ=
X-Google-Smtp-Source: ABdhPJzy09oHXXPIEkc4x2uZGT9auvTvNgyK+/xatDPuH4RTBOQg2Iza4sFrmUraTOeOlmtNHRtyjg==
X-Received: by 2002:a05:6e02:16c5:: with SMTP id 5mr25159344ilx.143.1634063606834;
        Tue, 12 Oct 2021 11:33:26 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x5sm2257999ioh.23.2021.10.12.11.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:33:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/5] dynamic debug for -next
Date:   Tue, 12 Oct 2021 12:33:05 -0600
Message-Id: <20211012183310.1016678-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Greg, Jason, 

Please consider these "more selective verbose info" patches for your
-next tree:

- show module name in query from $module.dyndbg="...;..."
- don't log command input with quotes user might use, it only confuses.
- silence log of empty/tail query.
- refine verbosity: summary..detail: 1..4

While doing stress testing with (something like):
  echo "+p; -p; +p; -p; +p; -p; +p; -p; +p; -p" > control

The existing v2pr_info("changed:") is called ~30k times (~3k
callsites, 10x) on my desktop kernel, and the syslog work completely
overwhelms and hides the static-key IPI overheads (using this
workload).

While verbose=1 silences this, it also stops most parsing vpr-infos,
as I found while submitting 4kb command buffers, and seeing short
writes and resulting bad commands kernel-side.  I needed to hide the
"changed" messages, but still see the parsing error (and submit
context), where the short write and resulting illegal command revealed
itself.

The script fix was to syswrite the prepared multi-command string,
avoiding perl's buffered io, but the kernel-side tweaks made it easier
to isolate and debug my userspace problem filling the 4kb command
buffer.

With these changes, the script elicits this log; with last of 96
queries logged at v=3, then benchmarked with v=0.

FWIW, the script runs 299k simple flag changes @ 125x/s.
For static-key changes, its MUCH slower, taking 4s each.
500x cost is not unreasonable, considering systemwide IPI.

model name	: AMD Ryzen 7 5800H with Radeon Graphics (16 core)

v=3 messages, per query.
[  727.006884] dyndbg: query 95: <file "*" module "*" func "*"  -mf # off > mod:<*>
[  727.007268] dyndbg: split into words: <file> <*> <module> <*> <func> <*> <-mf>
[  727.007657] dyndbg: op=<->
[  727.007813] dyndbg: flags=0x6
[  727.007973] dyndbg: *flagsp=0x0 *maskp=0xfffffff9
[  727.008320] dyndbg: parsed: func=<*> file=<*> module=<*> format=<> lineno=0-0
[  727.009205] dyndbg: applied: func=<*> file=<*> module=<*> format=<> lineno=0-0

v=2 message, summarizing command buffer submission.
[  727.009584] dyndbg: processed 96 queries, with 299040 matches, 0 errs

benchmark 2 queries: 1- a wildcard in all terms, 2- baseline, no terms

qry: ct:48 x << 
  file "*" module "*" func "*"  +mf # on ;  file "*" module "*" func "*"  -mf # off 
 >>
len: 4080, 576
Benchmark: timing 10 iterations of no_search, wildcards...
 no_search:  0 wallclock secs ( 0.00 usr +  0.08 sys =  0.08 CPU) @ 125.00/s (n=10)
            (warning: too few iterations for a reliable count)
 wildcards:  1 wallclock secs ( 0.00 usr +  0.16 sys =  0.16 CPU) @ 62.50/s (n=10)
            (warning: too few iterations for a reliable count)

Conclusion: Wildcarding isn't terribly expensive, so it is fair game
for format matching, just like the other fields.

qry: ct:49 x << 
  file "*" module "*" func "*"  +p # on ;  file "*" module "*" func "*"  -p # off 
 >>
len: 4067, 490
Benchmark: timing 10 iterations of no_search, wildcards...
 no_search: 40 wallclock secs ( 0.00 usr + 40.08 sys = 40.08 CPU) @  0.25/s (n=10)
 wildcards: 40 wallclock secs ( 0.00 usr + 40.37 sys = 40.37 CPU) @  0.25/s (n=10)
bash-5.1# 

Here, +p -p static-key toggle dominates the workload, and is MUCH
slower than comparable simple-flag toggling above.


I do hope that verbose= is not frozen API.
It has always been an integer, not a boolean, implying range.

It has also seen refinement since its origin:

commit 74df138d508e ("dynamic_debug: change verbosity at runtime")

This made verbose usable as a knob, w/o requiring reboot, but also
(implicitly) made it API, because it got exposed to userspace ?

commit 481c0e33f1e7 ("dyndbg: refine debug verbosity; 1 is basic, 2 more chatty")

This altered the callsite "changed" info to verbose=2 (amongst others),
but that really wasn't enough selectivity to cope with the situation
described above.


Jim Cromie (5):
  dyndbg: show module in vpr-info in dd-exec-queries
  dyndbg: refine verbosity 1-4 overview-detail
  dyndbg: use alt-quotes in vpr-infos, not those user might use
  dyndbg: vpr-info on remove-module complete, not starting
  dyndbg: no vpr-info on empty queries

 lib/dynamic_debug.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

-- 
2.31.1

