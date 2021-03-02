Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3A032A7BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835078AbhCBQ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:28:51 -0500
Received: from belmont94srvr.owm.bell.net ([184.150.200.94]:56410 "EHLO
        mtlfep05.bell.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573039AbhCBOIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:08:39 -0500
Received: from bell.net mtlfep02 184.150.200.30 by mtlfep02.bell.net
          with ESMTP
          id <20210302135238.BMMW52743.mtlfep02.bell.net@mtlspm02.bell.net>;
          Tue, 2 Mar 2021 08:52:38 -0500
Received: from [192.168.2.49] (really [70.50.109.22]) by mtlspm02.bell.net
          with ESMTP
          id <20210302135238.EQIW3672.mtlspm02.bell.net@[192.168.2.49]>;
          Tue, 2 Mar 2021 08:52:38 -0500
To:     Helge Deller <deller@gmx.de>, paulmck@kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202102281205.3F9aEA0G-lkp@intel.com>
 <20210228050526.GD2696@paulmck-ThinkPad-P72>
 <d14b90db-4052-544a-9743-748c653f3ad7@gmx.de>
 <20210228223302.GE2696@paulmck-ThinkPad-P72>
 <f2534985-89f3-1d00-0b72-13cd208d5201@gmx.de>
From:   John David Anglin <dave.anglin@bell.net>
Subject: Re: hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x228): cannot
 reach schedule_timeout_uninterruptible
Message-ID: <297aa0ff-f13b-2093-ea8a-60d270670434@bell.net>
Date:   Tue, 2 Mar 2021 08:52:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f2534985-89f3-1d00-0b72-13cd208d5201@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
X-CM-Analysis: v=2.4 cv=KPWfsHJo c=1 sm=1 tr=0 ts=603e4326 a=S6gQgrXzeH76ECG4GouVuA==:117 a=S6gQgrXzeH76ECG4GouVuA==:17 a=IkcTkHD0fZMA:10 a=dESyimp9J3IA:10 a=FBHGMhGWAAAA:8 a=DyGE3kjJqosRs_IipoMA:9 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
X-CM-Envelope: MS4xfAtUPAzeOtaxdyHh2MrZa7B7Mnii3IWuDXWIw1D69zS4dzstCZSTlgMtlZGZCkigiUj0bBYcXtpkly0v7PLGRu/E1KrDSqyBxBQtjv7enN/N5BLjEFJ3 O/hMXYU2LJRMGAja9/SIIZQdeiXCqiyYTGX3Ls68reKmXL2REebq9nDS8a0a5BoJkiudx3znKJ5HI0raqWDBmiwmxwx2ybtRsMyo0Zqt4kz4kPOR/nComd1q TWHjbj9SLOak9mRmMIc6Tw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMS0wMy0wMSA0OjM0IHAubS4sIEhlbGdlIERlbGxlciB3cm90ZToNCj4gScKgdGhp
bmvCoHRoZcKgb25secKgd2F5wqB0b8KgZml4wqB0aGlzwqBpbsKgYcKgY2xlYW7CoHdhecKg
aXPCoHRvDQo+IGVuYWJsZcKgQ09ORklHX01MT05HQ0FMTFMswqB3aGljaMKgbGV0c8KgZ2Nj
wqB1c2XCoC1tbG9uZy1jYWxsc8KgY29tcGlsZXINCj4gb3B0aW9uwqBhbmTCoHRodXPCoGNy
ZWF0ZXPCoGZhcsKgY2FsbHMuDQpUaGF0J3MgY3VycmVudGx5IHRoZSBvbmx5IHdheSB0byB3
b3JrIGFyb3VuZCB0aGUgUl9QQVJJU0NfUENSRUwyMkYgcmVsb2NhdGlvbiBlcnJvci7CoCBX
ZSBuZWVkDQpsb25nIGJyYW5jaCBzdHViIHN1cHBvcnQgaW4gNjQtYml0IGxpbmtlci4NCg0K
RGF2ZQ0KDQotLSANCkpvaG4gRGF2aWQgQW5nbGluICBkYXZlLmFuZ2xpbkBiZWxsLm5ldA0K
DQo=
