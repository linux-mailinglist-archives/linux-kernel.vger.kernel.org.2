Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAAD36395C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbhDSCWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:22:44 -0400
Received: from mail-177142.yeah.net ([123.58.177.142]:52581 "EHLO
        mail-177142.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhDSCWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:22:41 -0400
Received: from vivo.com (localhost [127.0.0.1])
        by mail-177142.yeah.net (Hmail) with ESMTP id C979C64410A;
        Mon, 19 Apr 2021 10:22:07 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AHgAiADIDmen--evL59Deart.3.1618798927815.Hmail.zhouchuangao@vivo.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0ga2VybmVsL2h1bmdfdGFzazogQWRkIGEgd2hpdGVsaXN0IGFuZCBibGFja2xpc3QgbWVjaGFuaXNtLg==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <2d990915-0e1e-1c10-1736-7061d753f912@i-love.sakura.ne.jp>
MIME-Version: 1.0
Received: from zhouchuangao@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 19 Apr 2021 10:22:07 +0800 (GMT+08:00)
From:   =?UTF-8?B?5ZGo5Lyg6auY?= <zhouchuangao@vivo.com>
Date:   Mon, 19 Apr 2021 10:22:07 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0pDH1ZIHUhNHRgfHxkaSxpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hOSFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1JQkpPTEpCSE5MN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Mxw6Ejo*Mj8WHhVWVh4NN05CPx4aCQ9VSFVKTUpDTEJDQkhLTUNNVTMWGhIXVQETFA4YEw4a
        FRwaFDsNEg0UVRgUFkVZV1kSC1lBWUhNVUpOSVVKT05VSkNJWVdZCAFZQU5LS0w3Bg++
X-HM-Tid: 0a78e7ef5fd86473kursc979c64410a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiAyMDIxLzA0LzE3IDIzOjEzLCB6aG91Y2h1YW5nYW8gd3JvdGU6Cj4+IFRoZSBtYWluIHB1
cnBvc2Ugb2YgdGhpcyBwYXRjaCBpcyB0byBhZGQgYSB3aGl0ZWxpc3QgYW5kIGJsYWNrbGlzdAo+
PiBtZWNoYW5pc20gdG8gdGhlIGh1bmcgdGFzayB0aHJlYWQuCj4KPldlIHN0b3BwZWQgdXNpbmcg
dGhlIHRlcm0gJ3doaXRlbGlzdCcvJ2JsYWNrbGlzdCcgZm9yIG5ldyBjb2RlIGluIExpbnV4IGtl
cm5lbCwKPmFuZCB3aGF0IHlvdSBhcmUgcHJvcG9zaW5nIGlzIHNvbWV0aGluZyBsaWtlICdpZ25v
cmVsaXN0Jy8nZmF0YWxsaXN0Jy4KPgo+SSB0aGluayB0aGF0IG1hdGNoaW5nIGJhc2VkIG9uIGNv
bW0gbmFtZSBpcyBwb29yLCBmb3IgY29tbSBuYW1lIGlzIHN1YmplY3RlZCB0bwo+aW1wZXJzb25h
dGlvbiBieSBtYWxpY2lvdXMgdXNlciBwcm9jZXNzZXMuCj4KPk1vcmVvdmVyLCBzcGVhayBvZiBz
eXprYWxsZXIgdGVzdGluZywgbW9zdCBvZiBoYW5nIHRhc2sgcmVwb3J0cyBhcmUgcmVhY3Rpb24g
dG8KPnNvbWVib2R5IGVsc2UgY29uc3VtaW5nIHRvbyBtdWNoIENQVSByZXNvdXJjZXMgKGUuZy4g
cHJpbnRrKCkgZmxvb2RpbmcsIHRvbyBtYW55Cj5wZW5kaW5nIHdvcmtxdWV1ZSByZXF1ZXN0cyku
IEV2ZW4gaWYgc29tZSBwcm9jZXNzIGlzIGluICdpZ25vcmVsaXN0JywgaXQgaXMKPnBvc3NpYmxl
IHRoYXQgc29tZSBwcm9ibGVtIHRoYXQgc2hvdWxkIGJlIHJlcG9ydGVkIGlzIGFscmVhZHkgaGFw
cGVuaW5nLiBFdmVuIGlmCj5zb21lIHByb2Nlc3MgaXMgaW4gJ2ZhdGFsbGlzdCcsIGl0IGlzIHBv
c3NpYmxlIHRoYXQgdGhlIGNhdXNlIG9mIGhhbmcgaXMgc2ltcGx5Cj5zb21lYm9keSBlbHNlIGlz
IGNvbnN1bWluZyB0b28gbXVjaCBDUFUuCj4KPkJ5IHRoZSB3YXksIEkgd2lzaCB0aGF0IGtodW5n
dGFza2QgY2FuIHJlcG9ydCByZWNlbnQgdG9wIENQVSBjb25zdW1lcnMsIGZvciBpdCBpcwo+cmFy
ZSB0aGF0IHRoZSBjYXVzZSBvZiBodW5nIGlzIGxvY2tpbmcgZGVwZW5kZW5jeSBwcm9ibGVtcyAv
IGhhcmR3YXJlIHByb2JsZW1zLgo+CgpUaGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbnMsCgpT
b21lIFNPQyB2ZW5kb3JzJyBkcml2ZXJzIG9yIHVzZXItbW9kZSBwcm9jZXNzZXMgbWF5IGJlIGlu
IEQgc3RhdGUgZm9yIGEgbG9uZyB0aW1lLAphbmQgbm9ybWFsbHkgdGhleSBkbyBub3QgY29uZmln
dXJlIEhVTkcgVEFTSywgc28gd2UgbmVlZCB0byBpZ25vcmUgdGhlc2UgdGFza3MgaWYKd2UgdXNl
IEhVTkcgVEFTSy4gCgpCeSBkZWZhdWx0LCBpZ25vcmVsaXN0IGFuZCBmYXRhbGxpc3QgYXJlIGVt
cHR5IGFuZCBjYW4gYmUgY29uZmlndXJlZCBieSB0aGUgdXNlcgooYXNzdW1pbmcgdGhlIHVzZXIg
a25vd3Mgd2hhdCB0aGV5IGFyZSBkb2luZykuCgpJIHdpbGwgdHJ5IHRvIGltcGxlbWVudCB0aGUg
ZnVuY3Rpb24gb2Yga2h1bmd0YXNrZCB0byByZXBvcnQgdG9wIENQVSBjb25zdW1lcnMuCgpUaGFu
a3MsCnpob3VjaGF1bmdhbw0KDQo=
