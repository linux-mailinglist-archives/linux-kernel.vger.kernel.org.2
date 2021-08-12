Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664EB3E9C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhHLBrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:47:46 -0400
Received: from m1364.mail.163.com ([220.181.13.64]:6045 "EHLO
        m1364.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLBro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=xLKxi
        /zWOGUxtP6rcR3NUfl+8cPXBofUQAWKEVhWYlk=; b=GO6MOZGG33O7y5zl7rMH7
        gQiGIdD1F9u+cN/+ik4xCP2Spq0ulfQyBFlqLk7O3S/tQaIAbKiYjCQijjKHyfbT
        DnyqHfKAwdyfBPbZ5VVsgKvn/4zGMNxXBDFmOGO4D49xqGHEKO2LdgYQP/FGZnAp
        gCafcZiMholQ0MeNsEuLRU=
Received: from slark_xiao$163.com ( [223.104.68.9] ) by ajax-webmail-wmsvr64
 (Coremail) ; Thu, 12 Aug 2021 09:46:48 +0800 (CST)
X-Originating-IP: [223.104.68.9]
Date:   Thu, 12 Aug 2021 09:46:48 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Sergei Shtylyov" <sergei.shtylyov@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] [v2,1/1] This aims to support Foxconn SDX55
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <c62d60aa-2e2d-8465-b0d9-e2409ef4de5a@gmail.com>
References: <20210811085635.4699-1-slark_xiao@163.com>
 <c62d60aa-2e2d-8465-b0d9-e2409ef4de5a@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3068a773.9a1.17b380a5d58.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMGowABXXs6KfRRh8Z_BAA--.5806W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBrQXsZF75bLJvfgAEsM
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjEtMDgtMTEgMTg6NTg6MDksICJTZXJnZWkgU2h0eWx5b3Yi
IDxzZXJnZWkuc2h0eWx5b3ZAZ21haWwuY29tPiB3cm90ZToKPkhlbGxvIQo+Cj5PbiAxMS4wOC4y
MDIxIDExOjU2LCBTbGFyayBYaWFvIHdyb3RlOgo+Cj4+IEZveGNvbm4gU0RYNTUgVDc3VzE3NSBk
ZXZpY2UgaXMgd29ya2luZyBpbiBQQ0llIG1vZGUgbm9ybWFsbHkuCj4+IFlvdSBjYW4gZmluZCBp
dCBpbiBkcml2ZXJzL2J1cy9taGkvcGNpX2dlbmVpcmMuYyBmaWxlLgo+Cj4gICAgcGNpX2dlbmVy
aWM/IDotKQo+Cj4+IEJ1dCBpbiBzb21lIHNjZW5hcmlvLCB3ZSBuZWVkIHRvIGNhcHR1cmUgdGhl
IG1lbW9yeSBkdW1wIG9uY2UgaXQgY3Jhc2hlZC4KPj4gU28gYSBkaWFnIHBvcnQgZHJpdmVyIGlz
IG5lZWRlZC4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYz
LmNvbT4KPlsuLi5dCj4KPk1CUiwgU2VyZ2VpCgpIaSBTZXJnZWksCiAgIFllcywgSSBkaWRuJ3Qg
bWl4IHRoZW0gdXAuIE91ciBwcm9kdWN0IHN1cHBvcnRzIDMgbW9kZXM6IFBDSUUgb25seSwgVVNC
IG9ubHksIGFuZCBQQ0lFK1VTQi4KICAgTm9ybWFsbHksIGl0IHdvdWxkIGJlIFBDSUUgbW9kZS4g
V2hlbiB3ZSB3YW50IHRvIHJlcHJvZHVjZSBzb21lIGNyYXNoIGlzc3VlLCB3ZSB3aWxsIHN3aXRj
aCBpdCBmcm9tIFBDSUUgbW9kZSB0byBQQ0lFK1VTQiBtb2RlLgogIEluIHRoaXMgc2NlbmFyaW8s
IHRoZSBVU0IgcG9ydCBpcyB1c2VkIGZvciBjYXB0dXJpbmcgbWVtb3J5IGR1bXAgYXMgb3VyIHRv
b2wgaXMgZGVzaWduZWQgYmFzZWQgb24gUXVhbGNvbW0gVVNCIFNhaGFyYSBwcm90b2NvbC4KClRo
YW5rcy4=
