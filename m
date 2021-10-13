Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D6942C773
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhJMRUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:20:40 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:41571 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJMRUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:20:38 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2021 13:20:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1634145514;
  h=to:cc:references:from:subject:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PneUHLGWfLGnatJljaOllwxclWcLZAsPhT+WU+/HThM=;
  b=I3htSDPQkd8Ma5Tgx5QiAcDrL4m83q5XREbI0e26G96G9qeGMQKzsYjm
   2hjWsN5lMC7WeaPvpZ/9bK3cTcldK6Oh2NLX6FDFiaBUJz7Ii2xi1sRly
   mA4CC+96uVOkZlo3wLgb4uwXgmvtsdEz9Wy5pvVB0Hz/0qit19JENtPn7
   s=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: caRhzt2AoxTr1np52zDbGFxNskESKu9/I4g2I+JxQn+n8k1c0tF7GOXShD5WvkLJ59ilnkgQCH
 CIVuCiBKbOnbcjBUATbq43mbVWut+0fkaxURZ5pXqBbI6jwxa5gnwTaVfg3LYNKNHmCB8PXztS
 R/IX4LgYCB0XW1YaW0Ehvubt5HJoBZUJ2Qe594hfb7sFYECM7jxbhe3WpSGVaPUTDEjYWy1iH7
 5I/7QRLiWBovOAg0OKvwn34vZn49huk2y/jH6pj1d8ApoOZzS5OB6ESgFLfn5OK6+8lFW95Nny
 vb0bB8zkioJcQxURX6pKB8YF
X-SBRS: 5.1
X-MesageID: 54684362
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:MlPFx6vYqRJx6LF5d87wiGyRMufnVOdZMUV32f8akzHdYApBsoF/q
 tZmKT+Gaa3fYGOkKNsibt+18klXvJSAxtRkGwNrrS1jRXxH+JbJXdiXEBz9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZQP0VOZigHtIQMsadUsxKbVIiGHpJZS5LwbZj29cw2IPhWGthh
 PupyyHhEA79s9JLGjp8B5Kr8HuDa9yr5Vv0FnRnDRx6lAe2e0s9VfrzFonoR5fMeaFGH/bSe
 gr25OrRElU1XfsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0qS2TV1hUp/0l20c95NJ
 NplspmidBkuMr/2pNtaUzxySxFTH44a0eqSSZS/mZT7I0zudnLtx7NlDV0sPJ1e8eFyaY1M3
 aVGcnZXNEnF3r/ohuLgIgVvrp1LwM3DFYUToHx/ixreCu4rW8vrSKTW/95Imjw3g6iiGN6DO
 5RJNWExNnwsZTVgBG80V4oUmtyVrSjCK2UG+GrKjKUotj27IAtZj+G2bYu9lsaxbcdNmUedr
 GXL1370DhETKJqUzj/t2mL82MfMkDn9VYZUE6e3ntZyjUGe3H47CRsYT1K3rPC1zEmkVLp3L
 UAZ4SMzqa4z+VawZtb6WBK8rTiPuRt0c9NUHv036UeW1qPO5BieB3QDUBZObdUnsIk9QjlC/
 luImc75QD9iqruYTVqD+bqO6zC/Iy4YKSkFfyBscOcey4C9+sdp1EuJF4s9Vv7u5jHoJd3u6
 zePvhUggLkBt/I0kKWe1wj3rhCP+rGcG2bZ+T7rdm6i6wp4YqusaIqp9UXX4J58EWqJcrWSl
 CNbw5bGvYjiGbnIzXbXGLxcQ9lF8t7caGWE6WODCaXN4NhEF5SLRotX/C1lbHlgNsIJaFcFi
 2eC5FsPuve/0JasBJKbgr5d6ex2k8AM9vy/D5g4i+aihLAqK2drGwk0NCatM5jFyhRErE3GE
 c7znTyQJXgbE7976zG9Wv0Q17QmrghnmziPHc6nlUz9jeHCDJJwdVvjGADRBgzexPnVyDg5D
 v4Fb5fao/mheLyWjtbrHX47cglRcClT6WHeoM1LbO+TSjeK60l6Y8I9NYgJItQ/94wMz7+g1
 ijkBidwlQqu7VWaeF7iQi0yN9vSsWNX8CtT0doEZg3zhRDOoO+Hsc8iSnfAVeB/rrI8lqQoE
 6BtlgfpKq0ndwkrMg81NPHVhIdjaA6qlUSJOS+kayI4ZJluW0rC/dqMQ+cl3HJm4vOfuZRsr
 ru++BncRJZfFQ1uANyPMKCkzk+rvGhbk+V3BhOaLt5WcUTq0Y5rNy2u0aNnf5BScU3OlmmAy
 gKbIRYEvu2R8YU7x8bE2PKfpICzHuogQkcDRzvH7ay7PDXx93a4xdMSS/6BeD3QDTum+Kira
 ehP4ev7NfkLwARDv4ZmSu45xqMi/dr/4bRdy108TnnMal2qDJJmI2WHgpYT5vEcmOcBtFLvC
 EyV+9RcNbGYA+/fEQYcdFg/c+CO9fAIgT2Ov/47F1r3uX1s972dXEQMYxTV0H5BLKF4OZ8Oy
 Ps6vJJE8BS2jxcnP4rUji1Q8GjQfHUMX79+68MfCY7vzAEq1ktDcdrXDSqvuMODbNBFM08LJ
 D6IhfWd2+QAlxSaK3djR2LQ2ed9hIgVvEEYxVAPEF2Fh97Zi6JlxxZW6zk2ElxYwxgvPzif4
 YS325mZ/Zmzwgo=
IronPort-HdrOrdr: A9a23:8Mj3RK6pxMeUlTlt4gPXwV+BI+orL9Y04lQ7vn2ZFiY7TiXIra
 yTdaoguCMc6AxxZJkh8erwXZVoMkmsiqKdhrNhQYtKPTOWxVdASbsN0WKM+UyZJ8STzJ876U
 4kSdkFNDSSNykLsS+Z2njALz9I+rDum8rJ9ISuvEuFDzsaD52Ihz0JezpzeXcGIjWua6BJdq
 Z0qvA33AZJLh8sH7qG7zQ+LqT+juyOsKijTQ8NBhYh5gXLpTS06ITiGxzd+hsFSTtAzZor7G
 CAymXCl+uemsD+7iWZ+37Y7pxQltek4txfBPaUgsxQDjn3kA6naKloRrXHljEop+OE7kosjb
 D30lgdFvU2z0mUUnC+oBPr1QWl+DEy60X6wVvdunfnqdyRfkNwN+NxwaZiNjfJ4Uspu99xlI
 hR2XiCipZRBRTc2Azg+tnhTXhR5wmJiEtntdRWo21UUIMYZrMUh5cY5llpHJAJGz+/wJw7Ed
 NpENrX6J9tABOnhkjizyxSKeGXLzAO9k/seDlEhiXV6UkWoJlB9Tpb+CRF9U1wsq7USPF/lq
 z52+pT5ehzpmJ/V9MLOA47e7rDNoX6e2OEDIujGyWUKEg5AQO4l3fW2sR+2Aj4Qu1E8HMN8K
 6xJm+w81RCI37TNQ==
X-IronPort-AV: E=Sophos;i="5.85,371,1624334400"; 
   d="scan'208";a="54684362"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0xSFbQXJT5iSIeuEYaR1SNrpIXPeOggR/711sB9BJffMsBUFgJCcs3/Ulb0itZworI/Q706/ebqVaHL7brPb8Ua8qYDlX4BuEL1InlkG1Moe+lziXlZDvTjn/eXHOzBzFzyfhFNMkopb56q6TSkUH4pj0jlR/ko8Kk6tbS/qXk4TWimBGHNgkJiIdRDLlUiGKpuFUwW18+qAfA9+RFCv4jMBv5ucI3vGHLYKPEnuk8B1fHCKRdKThwu+Bs2qRZDNT8n7zUGH9l+QUxYt36O3HwkTbf2bjMHA+3eWuGbweQmCAFA4ji3NNGKiKp8CH1jVpxNuze/bgwG4d3iAnfaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09IRYgV5pIWmFRaLh6bfJxKambYAjAtIZxRQIH+8kgg=;
 b=dygo/xlYdctSiF+McexGozfX9W09DoA7dR1RBWiJTm6oYIz1VEb22cGElLhVdjJ/Umq5Acsk3rk14ExwCOBTTAgkyMHsGSZ5LRFhnYZ+G5vuQZctX+VXHR3TpEG1PPOoJcedzo7BCQjfTQqXoW+Go4kWCQRyg+7JutyhFvAt5ExfOkXOXOr7zuWZ+fCTbeZuyhVjIFjQXLekBKW/UmQNW2Vh2Qa+J+qcBisk0BXUO6UzCrUDOqfXSkMYLJmrEyg+pj7fdtVo1H8bYlWWbGTzxRQXx/sJsyvsIOOlLmNXPBYLDztam1sa99rYj46yplMzLE44HEt5T4NXYQN3LDfHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09IRYgV5pIWmFRaLh6bfJxKambYAjAtIZxRQIH+8kgg=;
 b=uqYRjwU6l1UlJGofssu33Oc9j4p+jQgoO4FA4CuihRX2U4psCUpmUMVX4ZrL4dusNf5fP57SOS/3ZCRPAj+bplq6Z39X0F0NXGwt8/7IN+tR8itzs/oMHlCaylhphe7wWq1kTQYi8JfYUJZ3korEpIM4YUQC5S3PBrft5Mbs6b4=
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <x86@kernel.org>, <jpoimboe@redhat.com>,
        <linux-kernel@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
        <ndesaulniers@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <98fdd068-d1c3-1f8c-18b7-13c3909ed9ca@citrix.com>
 <YWb3TdmyPK7GwBP4@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <2c707dd6-796e-2de6-bce9-d0242f010513@citrix.com>
Date:   Wed, 13 Oct 2021 18:11:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YWb3TdmyPK7GwBP4@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-ClientProxiedBy: LO2P265CA0492.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::17) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 586fdb94-9106-43d4-d1a6-08d98e6c7836
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR03MB6270AE466178CB1282636CECBAB79@SJ0PR03MB6270.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpDxQgD6CFrGXyH2Z4y0RtjezeW32nBJyYp3n3b6EHn8IFrR+jcL+KBY0QN/vQy5+025j9jBaryxba3Pb7JY9K/yaSuvniUx0JW02KpkKFGBW2BYkB+fmiBdmzL1WgR2EJi2Qq5pL1jSaaFsaQeikXKs6khv0TZ3LX3efaOa6sTkqnoVW4+pMAD4qz4X9aUtCgoY5n0pevgbFKLNLhO7iXT89lIgnwATeUS3zPQzfPXcX1Q1P1z1536yyPAmxNIt8AnAkAg7C38uHTUZQ88m/QsYX60aRsPEpjJRtUdc9ZiVu810CEZBDpDfk9zSmFhc+OF/dgD4YSgFK4gYAwPUhQKD60gw3hGoE7Jf4NEq2QMfG2VMjitkcTeLVGb2NP1FttlAajgO/nMHHSx2NlB/ZByXEEufL3RR6YZmw0Oqkb5K/VVLSu1izhZLQPBBORBkv8z70Gx2hpr3C1+vt5kvi3xtsmFQ5we5xvPhlqj/w3pJfd6dSskb+wMOxBTCM9L1G3Ds0asJYpp8XvGvLEMgAHDgvxVx/ccKUCILmr7T298o9T6iAbxBQCoMd1stcXRaRW8MCL76vnZrchMNrLmo2l0HU7QrdUj8xyD+UR1T8OyAkW4lHHCe2ksv12mUgfQj3r11KMXRKYJt4fMPln5Zg2c4QgE8pECQHp8KZgbezJjdPd8uCBBxiuSS1LpJKMBmtLEXI95Znwkpaf2pgiaQMPUG/S2/QAzudpbGzf5AKLakYL5n7/dPE3z2SfqBGhZAEDwHKMThewz58IFOsWjscA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(8936002)(6666004)(83380400001)(8676002)(36756003)(53546011)(6486002)(316002)(38100700002)(956004)(508600001)(107886003)(66556008)(82960400001)(2906002)(66946007)(5660300002)(66476007)(86362001)(16576012)(6916009)(26005)(31686004)(31696002)(4326008)(2616005)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SStiKzduMGF6d0NMc0xrRGtHczV6V3FNTlZEdW9DSXR2Z2J3c3Zub2ZnVkFs?=
 =?utf-8?B?enFyY1FNN2xDR2VDOWRhZXdrUTlJeFpkNG9UREs5WUNKZ0plVktSTHlMUDRy?=
 =?utf-8?B?ejR6aUJtZ2MxTFFEeC9rVlE2Nm5lemMvVEwzSDVuTlpsSXg0azkxd3kyVVlO?=
 =?utf-8?B?K3JuSHQxdDZpamNkQk50VWpJUEdWRzdDSmExT2hsMWJ5RmlScW1qU2xRUEFH?=
 =?utf-8?B?emppUjQrR29FRUNyTTkyNXp1bXdzNXRoZURISE52L1hmTS9sNXdzUjFCUzFY?=
 =?utf-8?B?K0ZhMmlRMTBseTFKdHVJcFJjVVl2cUNrT2x6MTJpYkZETmR2SG0yNjZ0WitM?=
 =?utf-8?B?dml6OVVzQnpCMTYvWkhudkZydGpRbzBmRjE0MGduK0JEakJ5UzZCZXN3aXNp?=
 =?utf-8?B?Tnh0RlJnZHgxMTQ1TVFLTU9Iekh4OUV0ZGh0VG1iOXhBaFlzbHhBcWh0ZGVo?=
 =?utf-8?B?NmJEekptVDhqbFhGUmh5MjM3RHBOaDNIM0J2Z2ZidUgraE5sdEN0Y0tzUFZs?=
 =?utf-8?B?bFNTWEI5UGVRZEFiTlhNK1BvZ1NCdjNGNi95dCtoR0tSV1QyZGhLdWJvQ2M5?=
 =?utf-8?B?TmZCVTRvaS95WjI2L05sWnppWHBtaTcrYmZuL2UrVCtqbW16L1ZQS3lqckZr?=
 =?utf-8?B?R3VuQlVubUE4dDZqa3g1U1dUblNkVzE3MG8wbzFQNkFCekxpU3RUdGk0Nmt3?=
 =?utf-8?B?ejNTcUI1YVduNXlDMWNwOS9oOTQzMjFOU2RpcFlRaHBZbzhPbFJwTzQ4QkxB?=
 =?utf-8?B?SVN1VHFtUUhFNVdaaTA4US9oVFJYK3MwcjBteFJ1dzZ0aytOTDF3aXNSUytN?=
 =?utf-8?B?YUxqN2psSWpYTGErREhsdHg5NUlzWVdDcHlVdjZCY0hXT2YrZEhDUGhpejNR?=
 =?utf-8?B?bWFxTmt1Q3V2YnorQURTWUJ6Qm1wbkE2MUNBcVc4c0duSlp3V1dLSGdwSEVK?=
 =?utf-8?B?U2pQVldNSUYvRnZxcTNvdi9OWkRLUGUzazFOaHprUFJDZWlwYVZ0eGdVa0R6?=
 =?utf-8?B?M0ZTUXZ1MW9LM0FjTlF3QUN1Y2ZmdThtdTJxSjRsVWxpM1F4aVkwTWVkOUp0?=
 =?utf-8?B?WklzMzZFVzd4YjJvMFd4Tk02VFJHYVRwd3NKWlUra2FkWmhFbEltd21oU2Qz?=
 =?utf-8?B?SVNGdFpIMDFpUVVSeXBTekNSNUsrS1lHUS9uZTdMTlJVVlIwUmliby91VElR?=
 =?utf-8?B?VnVpWmtaQ2hST1QzandLMEdZR01xdy9JVFJwcDVHRENBUHhEYWV0aVVlSVNm?=
 =?utf-8?B?Q081TlI2NlRGa1MyRzBPcUg2bTVnUDg4UEdCNGNVV2dJVURaL2ZRMVdiN1dz?=
 =?utf-8?B?Q3ZKeVVWTXJMbHJ1VW9xUndTRGpUcDVWWTJqWHhmWXpkM3EwcUZJSGFjcDRG?=
 =?utf-8?B?SDNEZEE0eXNRWllnOUZ3NHFvNlY0RkJEUk8rZjlmMEtvS1RnREx3SFJWc0d3?=
 =?utf-8?B?UkhmWGJGdFlNZDVRZWowWVV6RW5lZXpzYjg3WTViM2pvRm1ML3V5Q2dvSUpL?=
 =?utf-8?B?a1BteUxMVkJ0SkM5ZVBNNkVuM2lhZEEvLzUwU0pROWRoaHdCNXFEUlc2U0ts?=
 =?utf-8?B?eUVFMk4vT0tTSzdrNTVkT0JlTGZzdWRvTnQ1ajJ1YWwrcVhPcW1uYVBtTVdR?=
 =?utf-8?B?dGpIV3p2QzlVdDY0Z0lZODlEOWphVVNUUHFFYTVWTjRmZFNFZDVZQ3JKcTFO?=
 =?utf-8?B?c0VaaWxmVnlqUElJckJlekxoMTRZdTltM2NJZ0lXT3F5U1EveG1HcmkyazZX?=
 =?utf-8?Q?G+hNGRYckdYTPiIhwbcymOF8XerSWGJVzUgc2Ei?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 586fdb94-9106-43d4-d1a6-08d98e6c7836
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 17:11:17.5445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g43EWxUP0S6O4FOpgIDPEizdfp26sqnOjFLdHHFlOb3nGpbpE2T6yxcpdX9Se7xrKUgCnbEja7inZmjJtUykTn3HwWH0/fuYQbdUoUmNJts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6270
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2021 16:12, Peter Zijlstra wrote:
> On Wed, Oct 13, 2021 at 03:38:27PM +0100, Andrew Cooper wrote:
>> On 13/10/2021 13:22, Peter Zijlstra wrote:
>>> +/*
>>> + * Rewrite the compiler generated retpoline thunk calls.
>>> + *
>>> + * For spectre_v2=3Doff (!X86_FEATURE_RETPOLINE), rewrite them into im=
mediate
>>> + * indirect instructions, avoiding the extra indirection.
>>> + *
>>> + * For example, convert:
>>> + *
>>> + *   CALL __x86_indirect_thunk_\reg
>>> + *
>>> + * into:
>>> + *
>>> + *   CALL *%\reg
>>> + *
>>> + */
>>> +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
>>> +{
>>> +	void (*target)(void);
>>> +	int reg, i =3D 0;
>>> +
>>> +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
>>> +		return -1;
>>> +
>>> +	target =3D addr + insn->length + insn->immediate.value;
>>> +	reg =3D (target - &__x86_indirect_thunk_rax) /
>>> +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
>> This is equal measures beautiful and terrifying.
> Thanks! :-)
>
>> Something around here really wants to BUG_ON(reg =3D=3D 4), because
>> literally nothing good can come from selecting %rsp.
> Ack, I had to add rsp to get the offsets right, but indeed, if anything
> ever selects that we're in trouble.

Actually, all you need is space for the RSP thunk, not an actual RSP
thunk, and it's probably a wise move not to write one out.

You can fill it with 0xcc's, and make sure not to make it an exported
symbol.

>
>> Also, it might be a good idea (previous patch perhaps) to have some
>> linker assertions to confirm that the symbols are laid out safely to do
>> this calculation.
> I was hoping that since all this is in .S it would be immune from crazy
> things like a compiler and do as told. But I suppose carzy stuff like
> LTO (or worse BOLT) can totaly wreck this still (then BOLT won't care
> about linker script assertions either).
>
> I'll see if I can come up with something.

Another cross check could be something like:

unsigned long reg_to_thunk[] =3D {
=C2=A0=C2=A0=C2=A0 &__x86_indirec_thunk_rax,
=C2=A0=C2=A0=C2=A0 ...
};

because then BUG_ON(target !=3D reg_to_thunk[reg]) will catch any errors
from layout issues.

Using 0 for rsp could then subsume the individual check.

~Andrew

