Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD639995E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 06:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFCEwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 00:52:12 -0400
Received: from mail-m17641.qiye.163.com ([59.111.176.41]:43306 "EHLO
        mail-m17641.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhFCEwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 00:52:12 -0400
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m17641.qiye.163.com (Hmail) with ESMTP id 431786012C;
        Thu,  3 Jun 2021 12:50:26 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AEkAVwCrDqnnn92uf85TYapl.3.1622695826260.Hmail.wanjiabing@vivo.com>
To:     Fangrui Song <maskray@google.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Bernard Zhao <bernard@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gW3YyXSBkb2NzL3poX0NOOiBhZGQgdHJhbnNsYXRpb25zIGluIHpoX0NOL2Rldi10b29scy9rYXNhbg==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.158
In-Reply-To: <20210603034545.oe675lrtvtsvbedb@google.com>
MIME-Version: 1.0
Received: from wanjiabing@vivo.com( [58.213.83.158) ] by ajax-webmail ( [127.0.0.1] ) ; Thu, 3 Jun 2021 12:50:26 +0800 (GMT+08:00)
From:   Jiabing Wan <wanjiabing@vivo.com>
Date:   Thu, 3 Jun 2021 12:50:26 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh9PTFZCQxkYTx0ZTEwfSU9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1PS0lLTkhLTUxCN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6PhA6LQw4CT8KFRUVQkkOHUNOLyIaCxdVSFVKTUlJTUJOQ0lNTkJDVTMWGhIXVQwaFRESGhkS
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJSkhVQ0hVSk5DWVdZCAFZQUhOTEo3Bg++
X-HM-Tid: 0a79d035536bd997kuws431786012c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IAo+UmU6IFtQQVRDSF0gW3YyXSBkb2NzL3poX0NOOiBhZGQgdHJhbnNsYXRpb25zIGluIHpoX0NO
L2Rldi10b29scy9rYXNhbj4KPiBUaGFua3MhIFdpdGggYSBmZXcgc3VnZ2VzdGlvbnMsPgo+UmV2
aWV3ZWQtYnk6IEZhbmdydWkgU29uZyA8bWFza3JheUBnb29nbGUuY29tPgoKWWVz77yMbW9yZSBl
YXNpZXIgdG8gdW5kZXJzdGFuZC4KSSBhZ3JlZSB3aXRoIHlvdSBhbmQgd2lsbCBmaXggdGhlbSBp
biB2My4KCj4+K+WGheaguOeahOWFtuS7lumDqOWIhuWPr+iDveS8muiuv+mXruW3suWIhumFjeWv
ueixoeeahOWFg+aVsOaNruOAgumAmuW4uO+8jEtBU0FO5Lya5qOA5rWL5bm25oql5ZGK5q2k57G7
6K6/6Zeu77yMCj4+K+S9huWcqOafkOS6m+aDheWGteS4i++8iOS+i+Wmgu+8jOWcqOWGheWtmOWI
humFjeWZqOS4re+8ie+8jOi/meS6m+iuv+mXruaYr+acieaViOeahOOAggo+PisKPj4r5a+55LqO
6L2v5Lu2S0FTQU7mqKHlvI/vvIzopoHnpoHnlKjnibnlrprmlofku7bmiJbnm67lvZXnmoTmo4Dm
tYvvvIwKPj4r6K+35bCGIGBgS0FTQU5fU0FOSVRJWkVgYCDmt7vliqDliLDnm7jlupTnmoTlhoXm
oLhNYWtlZmlsZeS4rToKPgo+RGVsZXRlIFplcm8gV2lkdGggU3BhY2UgY2hhcmFjdGVycyBvbiB0
aGlzIGxpbmUuCj4KWWVzLCBJIHVzZSB2aW0gYW5kIGZpbmQgaXQsIHRvby4KCkJUVywgSSB1c2Vk
IHZzY29kZSByZW1vdGUgZXh0ZW50aW9uIHRvIHRyYW5zbGF0ZS4KSXQgc2VlbWVkIHRvIGJlIGEg
YmFkIGlkZWEuCgpUaGFua3MsCkppYWJpbmcKCgoKCg0KDQo=
