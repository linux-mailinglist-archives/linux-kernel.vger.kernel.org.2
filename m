Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4236ED3F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhD2PTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:19:07 -0400
Received: from mail-m17642.qiye.163.com ([59.111.176.42]:46962 "EHLO
        mail-m17642.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhD2PTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:19:04 -0400
Received: from vivo.com (localhost [127.0.0.1])
        by mail-m17642.qiye.163.com (Hmail) with ESMTP id 14B8322010B;
        Thu, 29 Apr 2021 23:18:15 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AB*ANgDFDju3UB4GeQss-4rk.3.1619709495070.Hmail.wanjiabing@vivo.com>
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
X-Originating-IP: 180.111.217.84
In-Reply-To: <20210429144121.v6ycsvwkk64s7grp@outlook.office365.com>
MIME-Version: 1.0
Received: from wanjiabing@vivo.com( [180.111.217.84) ] by ajax-webmail ( [127.0.0.1] ) ; Thu, 29 Apr 2021 23:18:15 +0800 (GMT+08:00)
From:   Jiabing Wan <wanjiabing@vivo.com>
Date:   Thu, 29 Apr 2021 23:18:15 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUofT1ZKHUpPSU5DSUJPGh5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1ISUhMQk5CSUxMN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6OVE6NRw*PT8RDkguOU88HioICFZPCRBVSFVKTUpCTEtCT0JOT0NOVTMWGhIXVQwaFRESGhkS
        FRw7DRINFFUYFBZFWVdZEgtZQVlKQ0tVSkpKVUlKTFVDT1lXWQgBWUFNSUJINwY+
X-HM-Tid: 0a791e358738d998kuws14b8322010b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IAo+SXMgeW91ciByb2JvdCBwdWJsaWMgYXZhaWxhYmxlPwoKU29ycnksIEkgc3RhcnRlZCB0byB3
cml0ZSB0aGUgcm9ib3QganVzdCBvbmUgd2VlayBhZ28uCkl0IGlzIG5vdCBzdHJvbmcgYW5kIGNv
bXBsZXRlIGVub3VnaCBzbyBpdCBpcyBub3QgcHVibGljIGF2YWlsYWJsZSBub3cuCkJ1dCBJIGFt
IHN0aWxsIHdvcmtpbmcgb24gaXQuIElmIGNvbXBsZXRlLCBpdCBjYW4gYmUgcHVibGljIGF2YWls
YWJsZS4KCkluIGZhY3QsIHRoaXMgcGF0Y2ggaXMgY2F0Y2hlZCBieSB0aGUgc2NyaXB0IGNhbGxl
ZCBjaGVja2luY2x1ZGUucGwKaW4gbGludXgvc2NyaXB0LiBUaGUgcm9ib3QganVzdCBydW4gdGhl
IHNjcmlwdCBhbmQgY2F0Y2ggaXQgOykuCgpUaGVyZSB3aWxsIGJlIG1vcmUgc2NyaXB0cyBpbiB0
aGUgcm9ib3QgYW5kIEkgdGhpbmsKaXQgd2lsbCBiZSBwdWJsaWMgYXZhaWxhYmxlIHNvb24uCgo+
YnR3LCBhcHBsaWVkIHRvIGFtZC1zdGFnaW5nLWRybS1uZXh0LgoKVGhhbmsgeW91IHZlcnkgbXVj
aC4KCj4KPlRoYW5rcwo+T24gMDQvMjksIEppYWJpbmcgV2FuIHdyb3RlOgo+PiAgCj4+ID5OaWNl
IGNhdGNoIQo+PiA+Cj4+ID5BcmUgeW91IHVzaW5nIGFueSB0b29sIHRvIGlkZW50aWZ5IHRoaXMg
cHJvYmxlbT8KPj4gCj4+IFllcywgSSBoYXZlIGEgcm9ib3QgaW5jbHVkaW5nIG1hbnkgZGV0ZWN0
aW5nIHNjcmlwdHMgOikKPj4gCj4+ID5SZXZpZXdlZC1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8Um9k
cmlnby5TaXF1ZWlyYUBhbWQuY29tPgo+PiA+Cj4+ID5PbiAwNC8yOSwgV2FuIEppYWJpbmcgd3Jv
dGU6Cj4+ID4+IEluIGNvbW1pdCA0ODI4MTJkNTY2OThlICgiZHJtL2FtZC9kaXNwbGF5OiBTZXQg
bWF4IFRUVSBvbgo+PiA+PiBEUEcgZW5hYmxlIiksICJodWJwLmgiIHdhcyBhZGRlZCB3aGljaCBj
YXVzZWQgdGhlIGR1cGxpY2F0ZSBpbmNsdWRlLgo+PiA+PiBUbyBiZSBvbiB0aGUgc2FmZSBzaWRl
LCByZW1vdmUgdGhlIGxhdGVyIGR1cGxpY2F0ZSBpbmNsdWRlLgo+PiA+PiAKPj4gPj4gU2lnbmVk
LW9mZi1ieTogV2FuIEppYWJpbmcgPHdhbmppYWJpbmdAdml2by5jb20+Cj4+ID4+IC0tLQo+PiA+
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyB8IDEgLQo+PiA+PiAg
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPj4gPj4gCj4+ID4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwo+PiA+PiBpbmRleCA4ZjBhMTM4MDdkMDUuLmRjYWE2
YjFlMTZhZiAxMDA2NDQKPj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGMuYwo+PiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29y
ZS9kYy5jCj4+ID4+IEBAIC01OCw3ICs1OCw2IEBACj4+ID4+ICAjaW5jbHVkZSAiZGNfbGlua19k
ZGMuaCIKPj4gPj4gICNpbmNsdWRlICJkbV9oZWxwZXJzLmgiCj4+ID4+ICAjaW5jbHVkZSAibWVt
X2lucHV0LmgiCj4+ID4+IC0jaW5jbHVkZSAiaHVicC5oIgo+PiA+PiAgCj4+ID4+ICAjaW5jbHVk
ZSAiZGNfbGlua19kcC5oIgo+PiA+PiAgI2luY2x1ZGUgImRjX2RtdWJfc3J2LmgiCj4+ID4+IC0t
IAo+PiA+PiAyLjI1LjEKPj4gPj4gCj4+ID4KPj4gPi0tIAo+PiA+Um9kcmlnbyBTaXF1ZWlyYQo+
PiA+aHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGc2lxdWVpcmEudGVjaCUyRiZhbXA7ZGF0YT0wNCU3QzAxJTdDUm9kcmlnby5T
aXF1ZWlyYSU0MGFtZC5jb20lN0NiOGZmMTYxYjNhOTA0YTQ5ZTU5ODA4ZDkwYjA5OTFkOSU3QzNk
ZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1NTI5NTgwMTM2Njk2
OTglN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYy
bHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9STdB
dEVpT2x6VXVSUWFnN3VBdUFyVXZmZDY0bDFiM2dzdHE3WlRldWNpayUzRCZhbXA7cmVzZXJ2ZWQ9
MAo+PiAKPj4gWW91cnMsCj4+IFdhbiBKaWFiaW5nCj4+IAo+Cj4tLSAKPlJvZHJpZ28gU2lxdWVp
cmEKPmh0dHBzOi8vc2lxdWVpcmEudGVjaAoKWW91cnMsCldhbiBKaWFiaW5nCg0KDQo=
