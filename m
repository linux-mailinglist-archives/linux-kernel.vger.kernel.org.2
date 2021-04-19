Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D636392B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhDSBq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:46:58 -0400
Received: from mail-177142.yeah.net ([123.58.177.142]:54854 "EHLO
        mail-177142.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhDSBq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:46:57 -0400
Received: from vivo.com (localhost [127.0.0.1])
        by mail-177142.yeah.net (Hmail) with ESMTP id 532B8643FE6;
        Mon, 19 Apr 2021 09:46:26 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AIUATwAUDmin4z7rh1*KA4pi.3.1618796786331.Hmail.zhouchuangao@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@suse.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0ga2VybmVsL2h1bmdfdGFzazogQWRkIGEgd2hpdGVsaXN0IGFuZCBibGFja2xpc3QgbWVjaGFuaXNtLg==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <YHryaegfV9jo6aiL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Received: from zhouchuangao@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 19 Apr 2021 09:46:26 +0800 (GMT+08:00)
From:   =?UTF-8?B?5ZGo5Lyg6auY?= <zhouchuangao@vivo.com>
Date:   Mon, 19 Apr 2021 09:46:26 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh4dQ1YfQhhOTh1IS0MZHklVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1JQkpPTEpDSE5JN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Mi46Lww6Lj8WEhVPAUwJE0pRMDpPCxJVSFVKTUpDTEJNTENNTEtPVTMWGhIXVQETFA4YEw4a
        FRwaFDsNEg0UVRgUFkVZV1kSC1lBWUhNVUpOSVVKT05VSkNJWVdZCAFZQU9KSkw3Bg++
X-HM-Tid: 0a78e7ceb2ac6473kurs532b8643fe6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiBTYXQsIEFwciAxNywgMjAyMSBhdCAwNzoxMzowMUFNIC0wNzAwLCB6aG91Y2h1YW5nYW8g
d3JvdGU6Cj4+IGVnOgo+PiBJbiBBbmRyb2lkIHN5c3RlbSwgd2UgdXN1YWxseSBhbmQgc29tZSBw
cm9jZXNzZXMgdG8gdGhlIHdoaXRlbGlzdC4KPj4gc3RhdGljIHRhc2tfdCB0YXNrX3doaXRlbGlz
dFtdID0gewo+PiAJeyJtZHJ0X3RocmVhZCIsIEhVTkdfVEFTS19XSElURUxJU1R9LAo+PiAJeyJj
aHJlX2t0aHJlYWQiLCBIVU5HX1RBU0tfV0hJVEVMSVNUfSwKPj4gCXsic2NwX3Bvd2VyX3Jlc2V0
IiwgSFVOR19UQVNLX1dISVRFTElTVH0sCj4+IAl7ImNjY2lfZnNtMSIsIEhVTkdfVEFTS19XSElU
RUxJU1R9LAo+PiAJeyJxb3NfaXBpX3JlY3YiLCBIVU5HX1RBU0tfV0hJVEVMSVNUfSwKPj4gCXtO
VUxMLCAwfSwKPj4gfTsKPgo+V2hhdCBhcmUgdGhlc2UgdGFza3MgZG9pbmcgdGhhdCB0aGUgaHVu
Zy10YXNrIGRldGVjdG9yIGZpcmVzIG9uIHRoZW0/Cj5TaG91bGQgeW91IGZpeCB0aGF0IGluc3Rl
YWQ/CgpUaGVzZSB0YXNrcyBhcmUgaW1wbGVtZW50ZWQgYnkgdGhlIFNvQyB2ZW5kb3IsIGFuZCBu
b3JtYWxseSB0aGV5IGRvCm5vdCBjb25maWd1cmUgSFVORyBUQVNLLCBzbyB3ZSBuZWVkIHRvIGln
bm9yZSB0aGVzZSB0YXNrcyBpZiB3ZSB1c2UKSFVORyBUQVNLLiAKSGVyZSBJIHdhbnQgdG8gcHJv
dmlkZSBhIGlnbm9yZWxpc3QgYW5kIGZhdGFsbGlzdCBtZWNoYW5pc20sIGRpZmZlcmVudAp1c2Vy
cyBvciB1c2Ugc2NlbmFyaW9zIGNhbiBiZSBtb2RpZmllZCBhY2NvcmRpbmdseS4gClRoZSBkZWZh
dWx0IGlnbm9yZWxpc3Qgb3IgZmF0YWxsaXN0IGlzIGVtcHR5LgoKVGhhbmtzLAp6aG91Y2h1YW5n
YW8NCg0K
