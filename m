Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280174257E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242648AbhJGQ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbhJGQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:27:21 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0159CC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 09:25:28 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id y201so9764608oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Quh5CwhJrhMwts1row+sDHXdLRUbxO8BF6swndVKvFY=;
        b=i/MsWp7YvHVYXYUfhlyTfpdUeeFpOyF/y+NqOu4hLZ9GiOnZ/mBRG2lmS8S5Cna2Vg
         iq56IrFzbCYyYieRAqf3vfdgfBHSn27gFTQt7ppmaRZfFAdG43JqTJqLjfGMBDwjsZGN
         scrlnmY2xFUDty+TIJVEtPhvgzJiPg7IWyh9zMPrrG+r6JDBli8E4Q+JaNtIauyHowJS
         O3teZbmk79zkC1YbCEVE1PkmCoY2uuCJCgLjGrFoD1NtnUEqnwPR/bkVTDxsgRoll5/W
         eG5suHixTa2uYtyuZ9Sw84qcGSbKi0qMec1h+KXLnQwuasc4fuPmZsV2uvmIaHixV6+v
         FahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Quh5CwhJrhMwts1row+sDHXdLRUbxO8BF6swndVKvFY=;
        b=pkWfaSo0PGGU0uI5BxyWheNoOC0gcC23cFuAg+VOe2ZKHOCb/ksOsGk1E2LSrG1teD
         DcArLEAPJ7nvFgfIqSz92x1SIizdikosZEsyB559BlagKOQB6XRmP/eDaeSsx7/Dh8qG
         rePoAoX4jcBd9646/u+TlSVhimtm0u4HwMqoRLYHcSmmwtsjJrDXuhP9lyeaZgwKljaG
         2Nc5PEuLRolNxNMzy5As6bQwc4Um30BMxpNpDLcb/Wn3BRMe1xcsohSTPGcs7mqyjTLN
         FUksPFsQNJYScqf1RsaywdaXCGvr3PZN2mSKZh1PR3xABOS24FOmUfC/ept3u+QrXsQJ
         3B4w==
X-Gm-Message-State: AOAM531XVroymKfXTPzGPQJ7QEkbJJC5KLLwhoWgaZ+Q1o0Y2O1MEE91
        vJP56rwW5cthNMbUD1DcLCPFJCmoR5KuxwgTLyE=
X-Google-Smtp-Source: ABdhPJw0HiGhqFmhHAndqbyQdohXZDjUYsZV8rp/o4KkVkc+VL0MynBZojtf4em7ZuzWCDLmQaoJD1qnCHDe/QHl0ac=
X-Received: by 2002:a05:6808:2128:: with SMTP id r40mr3951944oiw.24.1633623927375;
 Thu, 07 Oct 2021 09:25:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:7841:0:0:0:0:0 with HTTP; Thu, 7 Oct 2021 09:25:27 -0700 (PDT)
Reply-To: tonyelumelu5501@gmail.com
From:   Post office lome <togounionlomewesternoffice@gmail.com>
Date:   Thu, 7 Oct 2021 16:25:27 +0000
Message-ID: <CABY4=WCtd5AE==c3zy3hxUyfCsy+itttrBSyaFUzJ5ZjjH_8gg@mail.gmail.com>
Subject: =?UTF-8?B?Q2llbsSramFtYWlzIGZvbmRhIMSrcGHFoW5pZWsh?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2llbsSramFtYWlzIGZvbmRhIMSrcGHFoW5pZWshDQoNCkVzIG5vc8WrdMSranUganVtcyDFoW8g
dsSTc3R1bGkgcGlybXMgbcSTbmXFoWEsIGJldCBlcyBuZWR6aXJkxJNqdSBubyBqdW1zLA0KZXMg
bmVlc211IHDEgXJsaWVjaW7EgXRzLCB2YWkgasWrcyB0byBzYcWGxJNtxIF0LiBVbiB0xIFwxJNj
IGVzIHRvIHNha3UNCnbEk2xyZWl6OiBwaXJta8SBcnQsIGVzIGVzbXUgS3Jpc3RhbGluYSBHZW9y
Z2lldmEga3VuZHplLCBTdGFycHRhdXRpc2vEgQ0KVmFsxat0YXMgZm9uZGEgcsSra290xIFqZGly
ZWt0b3JlIHVuIHByZXppZGVudGUuDQoNClBhdGllc8SrYsSBIG3Ek3MgZXNhbSBwxIFyc2thdMSr
anXFoWkgdmlzdXMgxaHEt8STcsWhxLx1cyB1biBwcm9ibMSTbWFzLCBrYXMNCnNhaXN0xKt0YXMg
YXIgasWrc3UgbmVwYWJlaWd0byBkYXLEq2p1bXUgdW4gasWrc3UgbmVzcMSTanUgaXpwaWxkxKt0
DQpwxIFyc2thaXTEq2p1bWEgbWFrc3UsIGthcyBubyBqdW1zIGlla2FzxJN0YSBubyBpZXByaWVr
xaHEk2rEgW0NCnDEgXJza2FpdMSranVtYSBpZXNwxJNqxIFtLiBBcHN0aXByaW7EgWp1bXUgc2th
dGlldCBtxatzdSB2aWV0bsSTIDM4IMKwIDUz4oCyNTYNCuKAsyBOIDc3IMKwIDIg4oCyIDM5IOKA
syBXDQoNCk3Ek3MsIERpcmVrdG9ydSBwYWRvbWUsIFBhc2F1bGVzIEJhbmthIHVuIFN0YXJwdGF1
dGlza2FpcyBWYWzFq3RhcyBmb25kcw0KKFNWRikgVmHFoWluZ3RvbmEsIHNhZGFyYsSrYsSBIGFy
IEFTViBWYWxzdHMga2FzaSB1biBkYcW+xIFtIGNpdMSBbQ0KYXRiaWxzdG/FocSBbSBwxJN0xKtq
dW11IGHEo2VudMWrcsSBbSDFoWVpdCwgQVNWLiBpciBwYXbEk2zEk2ppcyBtxatzdSDEgHJ2YWxz
dHUNCm1ha3PEgWp1bXUgcMSBcnZlZHVtdSBub2RhxLxhaSwgxIBmcmlrYXMgQXB2aWVub3RhamFp
IGJhbmthaSBMb21lIFRvZ28sDQppenNuaWVndCBqdW1zIFZJU0Ega2FydGksIHV6IGt1cnUgdGlr
cyBub3PFq3TEq3RzIGrFq3N1IGZvbmRzIChVU0QgMSwyDQptaWxqb25pKSwgbGFpIHbEk2zEgWsg
aXrFhmVtdHUgbm8gasWrc3UgZm9uZGEuDQoNCkl6bWVrbMSTxaFhbmFzIGxhaWvEgSBtxJNzIGJp
asSBbSBwxIFyc3RlaWd0aSwga2Ega29ydW1wxJN0xIFzIGJhbmthcw0KYW1hdHBlcnNvbmFzIG5l
dmFqYWR6xKtnaSBrYXbEk2phIG3Fq3N1IG1ha3PEgWp1bXUsIGNlbsWhb3RpZXMgbm92aXJ6xKt0
DQpzYXZ1cyBsxKtkemVrxLx1cyB1eiBzYXZpZW0gcHJpdsSBdGFqaWVtIGtvbnRpZW0uDQoNClVu
IMWhb2RpZW4gbcSTcyBqxatzIGluZm9ybcSTamFtLCBrYSBqxatzdSBmb25kcyBpciBpZXNrYWl0
xKt0cyBVQkEgYmFua2FzDQpWSVNBIGthcnTEkyB1biBpciBnYXRhdnMgYXLEqyBwaWVnxIFkZWku
IFRhZ2FkIHNhemluaWV0aWVzIGFyIFVCQSBiYW5rYXMNCnNla3JldMSBcnUuIFZpxYZ1IHNhdWMg
VG9uaWpzIEVsdW1lbHUga3VuZ3MsDQoNCktvbnRha3RwZXJzb25hcyBlIC1wYXN0czogKHRvbnll
bHVtZWx1NTUwMUBnbWFpbC5jb20pDQoNCkzFq2R6dSwgbm9zxat0aWV0IHZpxYZhbSDFocSBZHUg
aW5mb3JtxIFjaWp1IHBhciBqxatzdSBha3JlZGl0xJN0xIFzIFZpc2EgVklTQQ0Ka2FydGVzIHBp
ZWfEgWRpIHV6IGrFq3N1IGFkcmVzaS4NCg0KSsWrc3UgcGlsbnMgdsSBcmRzOiA9PT09PT09PT09
PT09PT09PT09PQ0KDQpKxatzdSBtxKt0bmVzIHZhbHN0czogPT09PT09PT09PT09PT09PT09PT0N
Cg0KSsWrc3UgbcSBamFzIGFkcmVzZTogPT09PT09PT09PT09PT09PQ0KDQpKxatzdSB0xIFscnXF
hmEgbnVtdXJzOiA9PT09PT09PT09PT09PT09PQ0KDQpTdmVpY2llbmksDQpLcmlzdGFsaW5hIEdl
b3JnaWV2YSBrdW5kemUuDQo=
