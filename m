Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D181439496
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhJYLQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:16:29 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:45720 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhJYLQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1635160445;
  h=to:cc:references:from:subject:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wYGJXO1Tr2vyiCMg/r3zr/T4tBEmZ7uVTCxQVXn1nWk=;
  b=SXuQ9+qa9QUlVxuCezomxn0bCdfpYL+QbwX2OhxVpS0p6XQLj0VR/5af
   1zC0B7GCZ3pgHuFMrkpsU5+RMvXlUrcVqO3nrLTB70ReZjBfkVBgwo0zZ
   0Qt+r37w9xQqNzG65w9jNOM8Xo4KopqOl7Eb+mXwDSRNLgLTEVi+DPR51
   8=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: FwG9olmty3XJHRyg43awM/n+usDTAeqkvdaZaJTP/5oSOoAfta2voWYYsSe7xlvkyNt+WneDFd
 9jGLgv2/PkU7GEU0k2B7cO7dRWMZzExXySYNFoMB7LxeA00MZr9pDyNeEvMxL76SIva3HLODqg
 Oib8grpoZXsCc+5IxMC4FFCRZOuBSDaowjt/ap+J7egU/pdvIMw6m8zr9e2g1Nq8wSII0tdkC9
 YUq5ZyZF0alBzd/WCM2v3HCwu8350LRxi3skEUB9lGWFr3DGG8ogQaFuzbYCkq1PoqgwxUgikl
 jCFzaPL7z5Q5/a576YjWusF3
X-SBRS: 5.1
X-MesageID: 55958544
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:4LcxoqutWUh5iASq5Wry6ty7COfnVIhYMUV32f8akzHdYApBsoF/q
 tZmKT+Ebq7YZ2D8LtsiO4vl/UoE7ZXQyYcyGVRtrXtjQX4T+JbJXdiXEBz9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZQP0VOZigHtIQMsadUsxKbVIiGHhJZS5LwbZj29cw24XhWmthh
 PupyyHhEA79s9JLGjp8B5Kr8HuDa9yr5Vv0FnRnDRx6lAe2e0s9VfrzFonoR5fMeaFGH/bSe
 gr25OrRElU1XfsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0qS2TV1hUp/0l20c95NJ
 NplsaWocAE7eY33ld8TcV54IxtDYJ95weqSSZS/mZT7I0zudnLtx7NlDV0sPJ1e8eFyaY1M3
 aVGcnZXNEnF3r/ohuLgIgVvrp1LwM3DFYUToHx/ixreCu4rW8vrSKTW/95Imjw3g6iiGN6DO
 ptEOWczMHwsZTVyFwozEYIPgdu2lyTFViJyrBGWq7Qetj27IAtZj+G2bYu9lsaxbcNcm0eEj
 nzD4G3jD1cRM9n34TOM6HmlgODCtTn2VIIbCPuz8fsCqFSQ3mk7DBwQSEv+r/6kjEK3R9NYL
 QoT4CVGhawz8lG7C9rwRRu1pFaasRMGHdldCes37EeK0KW8yx6UGmUeXBZAbtI8vcM7TDBs0
 UWG9/vvDDBmrvucTHOB3riRpDK2fyMSKAcqYS4CUBtA5tzLo586hRGJScxseIaxk8HyMTL92
 TaHqG45nbp7pd8WxaWy+njIhDWjopWPRQkwji3RRmOq4QJ/TIGgbo2sr1Pc6J5oPNbHZlqMp
 n4Jn46Z9u9mJY6MkCilQ+gXGrytofGfP1X0jVdxEt8h/jK29niLeYFW/SE4JUF1P8JCcjjsC
 GfLtB9c/o97JnambaZrJYm2DqwC0afkBfzhV/bJcsBJZJlhMgOKlByCfmbJgTqryhJ11/hiZ
 9HLKq5AEEr2F4xj9SKPQfVa8YQm/S4cgkPjf62m/SuehO/2iGGudZ8JN16Hb+Yc5ayCoRnI/
 9s3C/Zm2ymzQ8WlPXGJqd97wUQiaCFhX8iv+pM/mvure1I+QAkc5+ntLaTNkmCPt59ekfvU5
 TmDU0tcxUuXaZbveFjSNC4LhF8CW/9CQZMH0c4EYA7AN5sLO9/HAEIjm3wfJuFPyQCb5aQoJ
 8Tpgu3Zahi1dhzJ+i4Gcb72p5F4eRKgiGqmZnT+PWFnJ8QxH1STqrcImzcDEgFUXkJbUuNl+
 9WdOv7zG8JfF2yO8u6PMJpDMG9dTVBCwbkvDiMk0/FYeVn28ZgCFsACpqRfHi34Ej2anmHy/
 1/PWX8w/LCRy6dooIihrf3V9O+BTrohdne26kGGtN5awwGBpTH9qWKBOc7VFQ3guJTcofTyO
 74NlKqiYZXqXj9i6uJBLlqi9opnj/PHrL5G1AV0WnLNalWgELR7JXeam8JIs8VwKnVx4mNag
 2qDpYtXP6unIsTgHAJDLQYpdL3bh/oVhiPT/bI+J0CjvH17+7+OUENzORiQiXMCcOspYd19m
 epx6tQL7wGfiwYxNorUhC5j6GnRfGcLVL8qt89GDdaz2BYr0FxLfbfVFjTyvMOUc9xJP0Rze
 m2UiaPOiq5y3E3Hd3ZvR3HB0fAE3cYFuQxQzU9ELFOMw4KXivgy1RxX0DI2UgUKkUkXj7MtY
 jBmbhQnK7+P8jFkgNl4c1qtQwwRVgeE/kHRykcSkDGLRUefSWGQfnY2PvyA/R5F/jsELCRb5
 ryR1E3sTS3uIJPqxiI3VENo967jQNh2+lGQkcyrBZ3YTZwzYD6jia6yf2sY7RDgBJpp1kHAo
 OBr+sd2aLH6anFM8/FqVdHC2ORCUg2AKUxDXeplrfEAEmzrcT2v3SSDdhKqccRXKv2WqUK1B
 qSC/C6Uu8hSAMpWkg0mOA==
IronPort-HdrOrdr: A9a23:SGc0Eav98x+tsYCWG0jF7cNo7skC5IMji2hC6mlwRA09TyXGra
 6TdaUguiMc1gx8ZJhBo7C90KnpewK5yXcH2/huAV7EZniYhILIFvAf0WKG+Vzd8kLFh5VgPM
 tbAs5D4ZjLfCVHZKXBkXqF+rQbsaG6GcmT7I+0pRodLnAJGtNdBkVCe2Gm+yVNNXl77PECZe
 OhD6R81l+dkDgsH76G7i5vZZmzmzSHruOrXTc2QzocrCWehzKh77D3VzCewxclSjtKhZMv63
 LMnQDV7riq96jT8G6T60bjq7Bt3PfxwNpKA8KBzuATNzXXkw6tIKBsQaeLsjwZqPymrHwqjN
 7PiRE9ONkb0QKfQkiF5T/WnyXw2jcn7HHvjXeenHvYuMT8AAk3DsJQ7LgpOSfx2g4FhpVRwa
 hL12WWu958FhXbhhnw4NDOSlVDile0iWBKq59Rs1VvFa8lLJNBp40W+01YVL0aGjjh1YwhGO
 5ySOnB+fdtd0+AZXyxhBgu/DWVZAV3Iv66eDlHhiTMuAIm20yRjnFohfD3p01wtq7UEPJ/lq
 L52qcBrsAHciZZV9MlOA47e7rCNoX6e2OEDIujGyWTKEg5AQO7l3fW2sR+2Aj4Qu1E8HMN8K
 6xJm+w81RCI37TNQ==
X-IronPort-AV: E=Sophos;i="5.87,180,1631592000"; 
   d="scan'208";a="55958544"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4CzFmb/0+6n2Howh7S8xRJAuknbqu/hDZi/IZohPBKWxNb4AKprHBOj9J+7BU7Cn2gLqOzRicBKbaARcyNMemqXU3BcMOT9ucacshWWu1QTJfbI6VEu5RkrUeZ+eY6nLtVjKUKVZJo6PKYbO0IeTyrQ8Ze6RR/fslxFzhOrXVkhVBbu06VyMlFBa8TIxXkLsqWKHvkI+SccMV9imHnULCeqqVFl7hTm9BfIZOMkp5kDOtWfaAOEgQFLNxKhHXcPIz1p1Gnpv32T04sCMFrROSkF5GwnmH9/6EBahqvFF1mur60S1KiqPTC339/F+tn/M0XNFT4FB3BYbt1GfTCxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYGJXO1Tr2vyiCMg/r3zr/T4tBEmZ7uVTCxQVXn1nWk=;
 b=nuRfk42QbWHEeN9kTyg9v0PK5qqpObxxsHs0B0JUiNFSeAPt770dZUGOaIdYKpQ+/tr/+zLYO0ydtHZTJLeUyKgHB/7KSkZ1E8mlGEZi7TeF6/cKZgc0Lr9NWqMJ66P5sQuA5U8E0mlNEUSCFHGtgKNjFQnM6ZEPXO3P60PQ6iLKylATLm/t4126yxPBFTdlwxFLFGJxlttZ+b3fcX84mhb9IeYObyb6JudDm8ITq6cuT/SQ5m2rbrOopSkLqvY8QaEHuEyn24Mahw65RAPXspsTGQnFDz+hpmaYR1iAW156QtEQNSnN6sEGjvDaqFFyzscdAGqH/jQ0lShmvqCI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYGJXO1Tr2vyiCMg/r3zr/T4tBEmZ7uVTCxQVXn1nWk=;
 b=RqRSAEZU1bJJRSnUcKrS/F5CMnACzfSc2FVFafr4kZO8Im5SjDR74VvuKtpc/qYuycbPyE2upcd2wz78ndkU3FbKZvEsKxq/fj2VEe8A49RlSX+k2FS2lHw5FegNVxaPyj1e0yBS8oSVc/UOhtYFFr+U2Dg/EKMn6f1I0mcOIxo=
To:     Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, <x86@kernel.org>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-4-namit@vmware.com>
 <YXaOLAIo7B0+1NUc@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v2 3/5] x86/mm: check exec permissions on fault
Message-ID: <73f3ff27-861f-ebd9-ae89-8fa4e206bc2d@citrix.com>
Date:   Mon, 25 Oct 2021 12:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YXaOLAIo7B0+1NUc@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-ClientProxiedBy: LO2P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::36) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e34211c5-3a22-4ebd-1f8a-08d997a88c4a
X-MS-TrafficTypeDiagnostic: BY5PR03MB5169:
X-Microsoft-Antispam-PRVS: <BY5PR03MB5169FCE1ABAC6C1AC9B91B2CBA839@BY5PR03MB5169.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJ5f0W29yoIuDa2r0OdvD0rL1fPVOfUmNUnzuQ7FOxLCwM50Kti9pXs2YpERZ95dP2Wezw4iOMIhEzPmmyHPKAm+RKZKEqoy7UemjNdZkAXaaErg3xlt1PKSkH4h8UHPx1bSGCWYKhEABkEXyoxXhDxgT5Ao8W5yiJEUKWVTzj5nLFHDE5Yus2get1gY/qf+AW6Rd0N+XeGvE/HyOuzglzQsICg4VEsOy2hGzRAh+YTasFgNSAS+P+IzDGpCL5pVk9v2Hh75uETYN7eRHoQeSlY3RKpgIwGSNJMxo8B4beo3XTcmbMx0E/c1jEHBJU+rfJgd57NNtDrPwtTvXMPddAKSsku16H2wljkxn0oJoYGTe1WnaezOv5zcO8nbM5mfXbbRNFzyr+mCyctlvTL0q5jI1Sphv77E9wHPT4gFBf+0TCc+owiQjmLAhEr/yQG9Otxd68hNc6Vxk/pY71WGpYjisVS/Ede3yzWhwmuQgDhM0LGkJazU0EUDWFChf1yIAFR3Bdp/uBGJuAWRUAUtKKhTfwIsOfWX1e+G9H8KHNa/xkb0L8vGv7euCfxa2uOQMWdu6ZebiqYybtFbmptbopWEz8bT+MkbqsOFRzPv/roiR5nxbZTXngrSXLApv9y+vPNPzKdeKyWzxYJTCtPwjTlOFX61DFAK+hGcGUX0JDINpj/wJb9mhoBmaLgYTlhc2z3xpcce0cbfzot+a54uTmBAGleX1MymZ7VFGmXC+pM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(83380400001)(4744005)(6486002)(186003)(82960400001)(6666004)(4326008)(2616005)(26005)(66556008)(8936002)(2906002)(31686004)(956004)(316002)(110136005)(5660300002)(31696002)(8676002)(66476007)(7416002)(36756003)(508600001)(38100700002)(54906003)(16576012)(53546011)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5rSGI0S1p3NW5Bd21wRFJqeEZ2UFhIeU1NMUVBejNyaW5ETS9MNVNDTFRC?=
 =?utf-8?B?UG5TcjBpenFubE5HcjNGZkRSQ3JFcXpuMFZNWlhMY29FTVZST0xWdTJHNjFO?=
 =?utf-8?B?Y0NlaERuZGxNWEpHdUVsWUZZUUw2UDkrRGxsd2J5dnBMZld5V1RZT2tpZEsy?=
 =?utf-8?B?aFBac3NkMmZhNWNrVCtLT3JvRGwydU9ieEF0N1g1eWl3bkM1NitmSk9aMWdZ?=
 =?utf-8?B?Q0NkREFySVIxQ2J2aWhxT2RiaVZXWTdPbElUQWVTaUZaY0ZCRVhza3JVemNv?=
 =?utf-8?B?cHhlZi9JWTFJWnRyclorVGpxbXZlbG1jczFGQWprNEdkQ1hPZmVIY2VacVQ4?=
 =?utf-8?B?bThKVHQrNWMzUmxyMnRrQzVvTVpkcERuOUI2emdyWXBCRTlMOG9ZVUVrYjF2?=
 =?utf-8?B?M2czcFo5eTJ6YThZalZuTGIveE41L0lDUnlVQ3BaeHVWeC9TMTFOcGl6ODJx?=
 =?utf-8?B?Mk9pbCszbHFnT1JhUUc2U0VzV2hWNVZDMjRCNWdqQTFRdlBvWGVzMzNvV0hi?=
 =?utf-8?B?QTJqQ1JvbFY5MU01blFOOEtINjY2Q2pCcHNWRHAzVTV0VXlxVzQxcUE5aHFp?=
 =?utf-8?B?K0FNa3BZdVc1bFhVNXdaOGk5TFUrcFBwb0E0anhlR1UrVHkvSnViak9pTWFU?=
 =?utf-8?B?cWNHeDFSTmRSczBhaHpJdHJzRzdtV3BjbXpKcEtTOC9hRTJuMFRiUUlWa0hI?=
 =?utf-8?B?emJmUkkyMXBGeUFmZmdkR243QkRNYU1nS041N3VaMFV2LzltcnRwMllIRlVX?=
 =?utf-8?B?SllRdXlPVy8zK1VIWGlYQk03RFhEQm9OcVlhSXpmT0x4ZlY1MDZUbittV214?=
 =?utf-8?B?UFVxdkhDSVZqWm5PRzU5Myt6OGdIQVZnQ3FBNDVGeVZZRWRoOW1OS282UVk0?=
 =?utf-8?B?OHRFWTFXelh1WHcwRFNTOStsQzdNdE0vOUFqeElQVzI1RDgzM2MxeCtaVlQ5?=
 =?utf-8?B?VkdyUUVRMVo4UjdKN0tZZ0xEYW9QRVhXUUNXdi9rcUtQNk42MzVHYjhoRHpx?=
 =?utf-8?B?a0VzMjN6WHRCTFpjWGJqajBjcTI0SUNBNHphSGhKcEp0UEJVTGtYUytyZStS?=
 =?utf-8?B?bHlHWmZ6ZGVBbHdrQUgxYlJCNmd5aWY0Q2d2OTV6eGM0QWc3Y0VBZm9sMlBn?=
 =?utf-8?B?cWRCN3VIVm5Ld3c3eHVVUmJ3M2ZVRjZPNks3NE1UeDROejhOdUNuK21kS0JU?=
 =?utf-8?B?NDBRSVJ1OWwyc0xIalBCc3VDS29UQkhFMGhTcVQ2Rmpqd0s1ZFk4YkRQUGo1?=
 =?utf-8?B?K1NkanpkZHg2NWhhMVVjYnFLdlR5ZmNPNmlVKzZGTzZDRWYvYWlkd0Rzem1C?=
 =?utf-8?B?dUYvMUJHVlF4M2Y3aGhDVWhMaDA3WTZhUlR5QXlOMHB2MDcyVlFhT0E1YW9B?=
 =?utf-8?B?WTNGVDMwZ3pBcTRpcktUVFNKMDdzdWVmQ0w0UlNXWDFvMTRPU1ViNFdUdkxJ?=
 =?utf-8?B?d3dvNVdUOEpLNkNLYjZXY3dBSHE1NUtsZHYwdUppZVE1SkJXc0c1TzdxTkxY?=
 =?utf-8?B?ODBnM29KWlhIZ0RnS1dRbUxMY1lJbWVsL0F5NitPQjYza3hqMEN2QUE4elhT?=
 =?utf-8?B?emhhdlB2ck5yVXJTbVpSM0hNUDMzZllzSStpSFFLdno2UUgyWWRpNnY0VTVB?=
 =?utf-8?B?NDlzKzFrcGFsTGhxWnBKaVpFWnkrWVdLcGJXVzJ6cmVabDVJdHV1V3JFV2Yz?=
 =?utf-8?B?aURQaWZxZHlQTlR0TFpva2ZKYlN3SG5ZbXl4WEc3VFp0RlNrY0RzeFZSMHZI?=
 =?utf-8?B?MmxWeU5HZEluRm5qQ0VrU0ttYm9YQm1OQmdVeXBjN09mSlFuQ1NVZW5zRUJx?=
 =?utf-8?B?Q0JxRGtnTldHaEw1ejRNbk0xbWxCeFZpSWxyb2hHRk9mNVZFY3BWTXI4V05n?=
 =?utf-8?B?UHVPWjNKT0dWZjZzQ0FyTEJONlUzcVNnbjVUQnFkd3lWdkNMUnhDaFZDbFBr?=
 =?utf-8?B?a0dpa1FMVWpvdit4dnFGdy9XWTRXOU5xdGRYWDl5YXRmajV3aTEzOElOSE40?=
 =?utf-8?B?MThLUkRZKzR0T0VtT0RFcjV5NEE3UlJkaFRicGkzaEVPbmg2clhDc0dIcEJs?=
 =?utf-8?B?b3BvZVpWOFdyOEhjMllNUCsyY21IWmJ6MTJvNHJWTjhkZ3JQTWxsVzgrWUVB?=
 =?utf-8?B?c0xGc0c5NThUK0lMb1ZTemdmT3d1YWxScklwRWF2T2x3czVkNGFpblExRzNV?=
 =?utf-8?B?MVZFemVUTVJVZnhKYjZMa3J2bUFuUldMeXpOVjM3RFJhRnV1YUpLb2xXTlBw?=
 =?utf-8?B?blFYZmo1ajdFOW5jS3pJdE11QmNRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e34211c5-3a22-4ebd-1f8a-08d997a88c4a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 11:14:01.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+2RFozTofDbyCBvFoHlOjCKA/Rtiz3+Vu6Q/EtzCIb/HWyZILM8LGF6hFBuUQ5rdgXgEomgYwnA8QGsFACQmboooQCVZNh1ovw0A17FKgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5169
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2021 11:59, Peter Zijlstra wrote:
> On Thu, Oct 21, 2021 at 05:21:10AM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>> Add a check to prevent access_error() from returning mistakenly that
>> page-faults due to instruction fetch are not allowed. Intel SDM does not
>> indicate whether "instruction fetch" and "write" in the hardware error
>> code are mutual exclusive, so check both before returning whether the
>> access is allowed.
> Dave, can we get that clarified? It seems a bit naf and leads to
> confusing code IMO.

There is no such thing as an instruction fetch (a read) causing a
modification to the mapping.=C2=A0 From this point of view, you'd never
expect to see them both set.

However, be aware that INSTR is only reported for NX || SMEP.=C2=A0 Without
either, instruction vs data accesses are distinguished internally (can
be demonstrated with SMAP) but not visible in the pagefault error code.

~Andrew

