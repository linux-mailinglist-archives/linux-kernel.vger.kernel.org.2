Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763AF3C220C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhGIKFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:05:54 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:53932 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhGIKFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:05:54 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2021 06:05:53 EDT
DKIM-Signature: a=rsa-sha256;
        b=idnxViDR8zTs8tLhLPn90N6h4SOibcigoePRaarLV8SrkPXutSnFuq9Zdy3SAiKxMThTYSagwWpQMxClLzJskQ0eB21wOY+u6EE5pL40qOqtT1Oi9zzEY3se7OPsc//Ay0qWlAA53uJS0XH7QKjMusiTkCn8jUAY5GK6nHK8IR4=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=Grmy6Yq9fjulii9ZElmL/OwFmRuhmOh8D45Ttua6yts=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m176216.qiye.163.com (Hmail) with ESMTP id BD406C20163;
        Fri,  9 Jul 2021 17:54:00 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ABEAoQDbD-*iJqfqrqFbUarq.3.1625824439751.Hmail.link@vivo.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com,
        Uladzislau Rezki <urezki@gmail.com>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gbW0vdm1hbGxvYzogdHJ5IGFsbG9jX3BhZ2VzX2J1bGsgZmlyc3QgdG8gZ2V0IG9yZGVyIDAgcGFnZXMgZmFzdA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <20210709093852.GY3840@techsingularity.net>
MIME-Version: 1.0
Received: from link@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 9 Jul 2021 17:53:59 +0800 (GMT+08:00)
From:   =?UTF-8?B?5p2o5qyi?= <link@vivo.com>
Date:   Fri, 9 Jul 2021 17:53:59 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUwZGFZCTBpPSB8eSh1KGExVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1OS0tNSEhKTEpON1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6OT46FCo*GT9WURIxCh0KCQo9GS4aCQpVSFVKTUlOQ0lPT09KSk1MVTMWGhIXVRcSFRA7DRIN
        FFUYFBZFWVdZEgtZQVlITVVKTklVSk9OVUpDSVlXWQgBWUFIS0lONwY+
X-HM-Tid: 0a7a8ab031ced976kuwsbd406c20163
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IFZtYWxsb2MgbWF5IG9mZmVuIGdldCBwYWdlcyBieSBsb29wIGludm9rZSBhbGxvY19wYWdz
LCB0aGlzIGlzCj4+IGNvc3QgdG9vIG11Y2ggdGltZSBpbiBjb3VudCB3YXRlcm1hcmsvY3B1c2V0
IG9yIHNvbWV0aGluZy4KPj4gTGV0J3MganVzdCB0cnkgYWxsb2MgYnkgYWxsb2NfcGFnZXNfYnVs
aywgaWYgZmFpbGVkLCBmdWxsYmFjayBpbgo+PiBvcmlnaW5hbCBwYXRoLgo+PiAKPj4gV2l0aCBt
eSBvd24gdGVzdCwgc2ltdWxhdGUgbG9vcCBhbGxvY19wYWdlIGFuZCBhbGxvY19wYWdlc19idWxr
X2FycmF5LAo+PiBnZXQgdGhpczoKPj4gc2l6ZQkJMU0JMTBNCTIwTQkzMAo+PiBub3JtYWwJCTQ0
CTEyNzgJMzY2NQk1NTgxCj4+IHRlc3QJCTM0CTg4OQkyMTY3CTMzMDAKPj4gb3B0aW1pemUJMjIl
CTMwJQk0MCUJNDAlCj4+IEFuZCBpbiBteSB2bWFsbG9jIHRvcCBzb3J0LCB6cmFtL2YyZnMgbWF5
IGFsbG9jIG1vcmUgdGhhbiAyME1CLCBzbywKPj4gSXQncyB3b3J0aCB0byB1c2UgYWxsb2NfcGFn
ZXNfYnVsay4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgSHVhbiA8bGlua0B2aXZvLmNvbT4K
Pgo+VGhhbmtzLiBJIHN1Z2dlc3QgeW91IHRha2UgYSBsb29rIGF0IHRoZSBjdXJyZW50IG1lcmdl
IHdpbmRvdyBhbmQgY2hlY2sKPmlmIGFueXRoaW5nIGFkZGl0aW9uYWwgbmVlZHMgdG8gYmUgZG9u
ZSBhZnRlciB0aGUgdm1hbGxvYyBidWxrIGFsbG9jYXRpb24KU29ycnkgZm9yIHRoYXQsIEkgd2ls
bCB3b3JrIGluIGxpbnV4LW5leHQKPmJ5IFVsYWR6aXNsYXUgUmV6a2kuCj4KPi0tIAo+TWVsIEdv
cm1hbgo+U1VTRSBMYWJzCllhbmcgSHVhbgoKCg0KDQo=
