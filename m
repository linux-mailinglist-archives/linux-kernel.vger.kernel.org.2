Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE13C4156
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 04:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhGLCyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 22:54:06 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:34180 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLCyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 22:54:05 -0400
DKIM-Signature: a=rsa-sha256;
        b=f6VNzGGLW9RFKIBYIe7Tx3IPWQZzPUB3X3EfSIzmwfbog+IqXVkzQtwHivmNg+oLwtMkNZObqchM9zahB6o/EG5IMMF7AIiX481PWozXt1ExyGHZZaV4fN91EY37vuaZgq2Osqfb9HgmUnZzkrZvNOMw8qYDyucMk5/R63gf93U=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=uBHOgmrlRNudJLzFYkkAN7h6x3/PG1Wa0llQ8TDzABs=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m176216.qiye.163.com (Hmail) with ESMTP id 91108C20131;
        Mon, 12 Jul 2021 10:51:16 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJUATgAyD3QlUlWGCE0F74q8.3.1626058276577.Hmail.link@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com,
        Uladzislau Rezki <urezki@gmail.com>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gbW0vdm1hbGxvYzogdHJ5IGFsbG9jX3BhZ2VzX2J1bGsgZmlyc3QgdG8gZ2V0IG9yZGVyIDAgcGFnZXMgZmFzdA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <20210709152945.f2c373e8834d4b8488fd027f@linux-foundation.org>
MIME-Version: 1.0
Received: from link@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 12 Jul 2021 10:51:16 +0800 (GMT+08:00)
From:   =?UTF-8?B?5p2o5qyi?= <link@vivo.com>
Date:   Mon, 12 Jul 2021 10:51:16 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk1LSVYeGEsaTU0YGh0YSE5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1OS0lLSElIQ0lIN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MS46Lxw6Aj9IKhcuFyw8OD5LPUxPCkNVSFVKTUlNS05DSUxNQ01NVTMWGhIXVRcSFRA7DRIN
        FFUYFBZFWVdZEgtZQVlITVVKTklVSk9OVUpDSVlXWQgBWUFJT0tMNwY+
X-HM-Tid: 0a7a98a03f01d976kuws91108c20131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4KPj7CoD5UaGFua3MuwqBJwqBzdWdnZXN0wqB5b3XCoHRha2XCoGHCoGxvb2vCoGF0wqB0aGXC
oGN1cnJlbnTCoG1lcmdlwqB3aW5kb3fCoGFuZMKgY2hlY2sKPj7CoD5pZsKgYW55dGhpbmfCoGFk
ZGl0aW9uYWzCoG5lZWRzwqB0b8KgYmXCoGRvbmXCoGFmdGVywqB0aGXCoHZtYWxsb2PCoGJ1bGvC
oGFsbG9jYXRpb24KPj7CoFNvcnJ5wqBmb3LCoHRoYXQswqBJwqB3aWxswqB3b3JrwqBpbsKgbGlu
dXgtbmV4dAo+Cj5UaGF0wqBtYXRlcmlhbMKgaXPCoG5vd8KgaW7CoG1haW5saW5lLMKgc2/CoHdv
cmvCoGFnYWluc3TCoExpbnVzJ3PCoDUuMTQtcmMxwqBwbGVhc2UuCk9LLCB0aGFua3MKCgoKCgoK
Cg0KDQo=
