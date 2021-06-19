Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC623AD7F4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 07:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhFSFKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 01:10:18 -0400
Received: from mail-m176237.qiye.163.com ([59.111.176.237]:35050 "EHLO
        mail-m176237.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhFSFKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 01:10:17 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jun 2021 01:10:17 EDT
DKIM-Signature: a=rsa-sha256;
        b=N+KVXKH0ItmCEuNrfRbD2QhvN4FNw4ADX+itE1yny9zOOoN/XA2/dndrRT6tRH7AFV5mgbwOMS405nJSgYyhQDBV5eXFBtafkL0/W4tvWv2TJHZsTYiDKRSxswKQDYfBrtpogaNdEzfjUBClH9JpPNRi24I/Ufp/Q9qfWZepfog=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=CEL5scdLJYmWlRUsoHbuMz0Iuackwz4/vIAEsKnDT0g=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m176237.qiye.163.com (Hmail) with ESMTP id 13562C400C4;
        Sat, 19 Jun 2021 13:01:34 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ABYAKQDNDmr9B7YYOVwFFKqU.3.1624078894067.Hmail.zhouchuangao@vivo.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJpdmVycy9udm1lL2hvc3Q6IFVzZSBrb2JqX3RvX2RldigpIEFQSQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <20210618141817.GA18781@lst.de>
MIME-Version: 1.0
Received: from zhouchuangao@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Sat, 19 Jun 2021 13:01:34 +0800 (GMT+08:00)
From:   =?UTF-8?B?5ZGo5Lyg6auY?= <zhouchuangao@vivo.com>
Date:   Sat, 19 Jun 2021 13:01:34 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUseSVZKTE1PHUIdHkJDHk5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1PT0pIQ0lJQ0JIN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6OSI6MCo*NT8WCUI5TCIiNC0MPT0wCi5VSFVKTUlPS0xDQ0JPSEtIVTMWGhIXVQETFA4YEw4a
        FRwaFDsNEg0UVRgUFkVZV1kSC1lBWUhNVUpOSVVKT05VSkNJWVdZCAFZQUlPSUw3Bg++
X-HM-Tid: 0a7a22a54403d9afkuws13562c400c4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiBGcmksIEp1biAxOCwgMjAyMSBhdCAwNzoxMDo1OEFNIC0wNzAwLCB6aG91Y2h1YW5nYW8g
d3JvdGU6Cj4+IFVzZSBrb2JqX3RvX2RldigpIEFQSSBpbnN0ZWFkIG9mIGNvbnRhaW5lcl9vZigp
Lgo+Cj5XaHk/ICBUaGF0IGp1c3QgbWFrZXMgdGhlIGNvZGUgaGFyZGVyIHRvIHJlYWQuCgpJbiBt
eSBvcGluaW9uLCB0aGUga29ial90b19kZXYoKSBpbnRlcmZhY2UgaXMgcHJvdmlkZWQgYnkgdGhl
IGtlcm5lbCBzbyB0aGF0CndlIGNhbiBnZXQgZGV2aWNlIGJhc2VkIG9uIGtvYmogd2l0aG91dCBo
YXZpbmcgdG8gcGFzcyBtb3JlIHBhcmFtZXRlcnMuCkkgdGhpbmsgaXQncyBlYXNpZXIgdG8gdXNl
LgoKVGhhbnNrLAp6aG91Y2hhdW5nYW8NCg0K
