Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F62636EA86
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhD2Mcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:32:45 -0400
Received: from mail-m17642.qiye.163.com ([59.111.176.42]:45042 "EHLO
        mail-m17642.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2Mco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:32:44 -0400
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m17642.qiye.163.com (Hmail) with ESMTP id 20772220127;
        Thu, 29 Apr 2021 20:23:15 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AN*ARACWDmq3kx33Z4tCR4oU.3.1619698995121.Hmail.wanjiabing@vivo.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Aric Cyr <aric.cyr@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Chiawen Huang <chiawen.huang@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>, Eric Yang <Eric.Yang2@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBSZW1vdmUgZHVwbGljYXRlIGluY2x1ZGUgb2YgaHVicC5o?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <20210429120504.sjruq5a3w2hdtusy@outlook.office365.com>
MIME-Version: 1.0
Received: from wanjiabing@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Thu, 29 Apr 2021 20:23:15 +0800 (GMT+08:00)
From:   Jiabing Wan <wanjiabing@vivo.com>
Date:   Thu, 29 Apr 2021 20:23:15 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGR5PTVZPHhgZGk4dGUIdT0NVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1ISUhNSk5MTUJPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6NVE6KTo4LD8WCkgQA0hIIU8POClPFC5VSFVKTUpCTUJDQkJOT0NMVTMWGhIXVQwaFRESGhkS
        FRw7DRINFFUYFBZFWVdZEgtZQVlITVVKTklVSk9OVUpDSVlXWQgBWUFPTE5KNwY+
X-HM-Tid: 0a791d954fcad998kuws20772220127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IAo+TmljZSBjYXRjaCEKPgo+QXJlIHlvdSB1c2luZyBhbnkgdG9vbCB0byBpZGVudGlmeSB0aGlz
IHByb2JsZW0/CgpZZXMsIEkgaGF2ZSBhIHJvYm90IGluY2x1ZGluZyBtYW55IGRldGVjdGluZyBz
Y3JpcHRzIDopCgo+UmV2aWV3ZWQtYnk6IFJvZHJpZ28gU2lxdWVpcmEgPFJvZHJpZ28uU2lxdWVp
cmFAYW1kLmNvbT4KPgo+T24gMDQvMjksIFdhbiBKaWFiaW5nIHdyb3RlOgo+PiBJbiBjb21taXQg
NDgyODEyZDU2Njk4ZSAoImRybS9hbWQvZGlzcGxheTogU2V0IG1heCBUVFUgb24KPj4gRFBHIGVu
YWJsZSIpLCAiaHVicC5oIiB3YXMgYWRkZWQgd2hpY2ggY2F1c2VkIHRoZSBkdXBsaWNhdGUgaW5j
bHVkZS4KPj4gVG8gYmUgb24gdGhlIHNhZmUgc2lkZSwgcmVtb3ZlIHRoZSBsYXRlciBkdXBsaWNh
dGUgaW5jbHVkZS4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFdhbiBKaWFiaW5nIDx3YW5qaWFiaW5n
QHZpdm8uY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjLmMgfCAxIC0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4+IAo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKPj4gaW5kZXggOGYwYTEzODA3ZDA1
Li5kY2FhNmIxZTE2YWYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nv
cmUvZGMuYwo+PiBAQCAtNTgsNyArNTgsNiBAQAo+PiAgI2luY2x1ZGUgImRjX2xpbmtfZGRjLmgi
Cj4+ICAjaW5jbHVkZSAiZG1faGVscGVycy5oIgo+PiAgI2luY2x1ZGUgIm1lbV9pbnB1dC5oIgo+
PiAtI2luY2x1ZGUgImh1YnAuaCIKPj4gIAo+PiAgI2luY2x1ZGUgImRjX2xpbmtfZHAuaCIKPj4g
ICNpbmNsdWRlICJkY19kbXViX3Nydi5oIgo+PiAtLSAKPj4gMi4yNS4xCj4+IAo+Cj4tLSAKPlJv
ZHJpZ28gU2lxdWVpcmEKPmh0dHBzOi8vc2lxdWVpcmEudGVjaAoKWW91cnMsCldhbiBKaWFiaW5n
DQoNCg==
