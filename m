Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AC93E3485
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhHGJxv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Aug 2021 05:53:51 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39637 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhHGJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:53:50 -0400
Received: from [192.168.1.107] ([37.4.249.97]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MwQKr-1n2LuI3f9B-00sKXM; Sat, 07 Aug 2021 11:53:23 +0200
Subject: Re: [RFC PATCH 1/3] drivers/mfd: rpisense: Raspberry Pi senseHAT core
 driver
To:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Charles Mirabile <cmirabil@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>
References: <20210807002722.2634585-1-jsavitz@redhat.com>
 <20210807002722.2634585-2-jsavitz@redhat.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdudVBHIHYy
 CgptUUlOQkZ0NmdCTUJFQUN1Yi9wQmV2SHhidkplZnlaRzMySklObW4yYnNFUFgyNVY2ZmVq
 bXlZd21DR0tqRnRMCi9Eb1VNRVZIRHhDSjQ3Qk1YbzM0NGZIVjFDM0FudWRnTjFCZWhMb0J0
 TEh4bW5lQ3pnSDNLY1B0V1c3cHRqNEcKdEp2OUNRRFp5MjdTS29FUHh5YUk4Q0YweWdSeEpj
 NzJNOUk5d21zUFo1YlVIc0x1WVdNcVE3SmNSbVBzNkQ4ZwpCa2srOC95bmdFeU5FeHd4SnBS
 MXlsajVianhXREh5WVF2dUo1THpaS3VPOUxCM2xYVnNjNGJxWEVqYzZWRnVaCkZDQ2svc3lp
 by9ZaHNlOE4rUXN4N01RYWd6NHdLVWtRUWJmWGcxVnFrVG5BaXZYczQyVm5Ja211NWd6SXcv
 MHQKUkp2NTBGUmhIaHhweUtBSThCOG5oTjhRdng3TVZrUGM1dkRmZDN1R1lXNDdKUGhWUUJj
 VXdKd05rLzQ5RjllQQp2ZzJtdE1QRm5GT1JrV1VSdlArRzZGSmZtNitDdk92N1lmUDF1ZXdB
 aTRsbitKTzFnK2dqVklXbC9XSnB5MG5UCmlwZGZlSDlkSGtnU2lmUXVuWWN1Y2lzTXlvUmJG
 OTU1dENna0VZOUVNRWRZMXQ4aUdEaUNnWDZzNTBMSGJpM2sKNDUzdWFjcHhmUVhTYUF3UGtz
 bDhNa0NPc3YyZUVyNElOQ0hZUUR5WmljbEJ1dUNnOEVOYlI2QUdWdFpTUGNRYgplbnpTektS
 Wm9POUNhcUlEK2ZhdkxpQi9kaHptSEErOWJnSWhtWGZ2WFJMRFp6ZThwbzFkeXQzRTFzaFhp
 ZGRaClBBOE51SlZ6RUl0MmxtSTZWOHBaRHBuMjIxcmZLaml2UlFpYW9zNTRUZ1pqak1ZSTdu
 bko3ZTZ4endBUkFRQUIKdENCVGRHVm1ZVzRnVjJGb2NtVnVJRHgzWVdoeVpXNXpkRUJuYlhn
 dWJtVjBQb2tDTndRVEFRZ0FJUVVDWElkYwo0Z0liQXdVTENRZ0hBZ1lWQ0FrS0N3SUVGZ0lE
 QVFJZUFRSVhnQUFLQ1JDVWdld1BFWkR5MjFPVEQvOUdpWkxkCnRSWWNteVJKZ2x0aVFRekFp
 UWRjSUQ3OGxHb1dwL3grci92Y1U2YjZqdVl1ZVR3Z1Iwclc3djdsMklSQnlEN24KSEp4YSt0
 SVNvUVpCZ2hvbE1JZmI5TXRoR09KTENZNzdrL1FoQWhuMzJOR1prZWp3OXR6a3MvNDBtclpT
 VVQ4NApaeWJzUVhyTE0vSFI2VElJL0RlUEIwbktEM0ppcHBzMlVIUUQ5cUQySWpFd1NRUGxI
 akNPckVaaDQ1UFo3bTkrClo5M0x6aVRlc1dabFlRdUxpSndzNHJLcHRIVzFkL3dSZWxzaG1t
 NlFxY0wybDRDL2U0MGVEQjlncTRkU1poOVgKUEVZbGxpeU5RaDdhMkxTZHVtRTFyK2NTd0lq
 RS91ZHRSdmRPOWFLb0psT2JVSzVkTmpTUEg3d0tUYndkWGRZRApHUHdEaFhkNThOQXdyK1BY
 QmxQajB0STFMQ3ErTEJ4ZUt6aFdYK0dWcTlEb2pWanlVREV4Rk5Ga1h1b0M3ZzhtClY5VDB0
 ZUJpdVpSbm91WEt3VjJGcHRaT0hIN0JVRVd0a0t0aGgxZXRmT1dwaWdCemtVN2JQc2ZJWVQr
 cnk5dGIKMW9KK3Y0MVBOYXFaRW1QVXBKeHZmek5UN3Ayd01lRDdaajlmMHJ1YlJQdExBSjJR
 R2pyRkhzdVh3QU9xcHl6ZQoxOEVidHNZazBOMHp1SEVoY2orUEJJQmZoMFlJWWQ1MW9mNkdJ
 aU95UjlxMFhYdHBsVUo3VDIvSDF1UXFrWGxwCitnVzRWa2lmc2NJckl1eWZueFpXMTJlSXZq
 NnlicVdMN2FZS0dZbVQ2aUxDUGJIWXlZY2F5bDRFa0ZjckNGN0UKZTBXVC9zY1ZNaE8vNVgv
 SGFOQTVIQngvcjUycGdMY3Y0aTlNeExRbVUzUmxabUZ1SUZkaGFISmxiaUE4YzNSbApabUZ1
 TG5kaGFISmxia0JwTW5ObExtTnZiVDZKQWpnRUV3RUNBQ0lGQWx0NmdCTUNHd01HQ3drSUJ3
 TUNCaFVJCkFna0tDd1FXQWdNQkFoNEJBaGVBQUFvSkVKU0I3QThSa1BMYmpic1AvamdqYVNz
 NUh0bGtBSXZXUytGcm15N2MKaG5jT0F4TFRWL0Q2UkV3SU95R0poRkt3d29pck55UTJnOXZV
 YTNZQ1lDZjFmSjh3RWhhS09COWQwTHBNUm5MNApkRVQ4ZDgyMzhFL3BLK0hxTktpSXNKaHM2
 SnNLOFpnalZRR3JtbWZua0dyWisxdjBIQnV4ZGljZ0duUC9XdHVBClVsOGw2Mi9BTGJheXlq
 KzYxQ2xyc0V0UklhcU82N0xJWXdQaVBEUkkrWGlNek5pR3pIRi8xUTZHUjAyUkg2YTMKRjg5
 ejhhUHhjSGkxWnZDdDJ5a3o2VUVjaHpQMHI1Z3FGSisvTC9VcHU4ME1YaVk0djVlSWFCNTJn
 VlBnaXlNQQpsTDJkRHMxbUladm5yUkxSWTJ0YjNtQVlOa1Y1QjVJRFQzcGtXeTZrS281T0Nn
 SytZZFlPUjhGTloyb04ydDhPCnJLK1ZudGFLN01NU0tIbG1ZL3NPd3RSbEVoMU9CbXJjQ3dH
 d21wLzA1R2tSNDZmL0lzaFJWZUZPUmF3K0dBcXQKUDIrQ0ZhMkNOQS9JSG5aTm95aWtsRHpQ
 UUhVVUdzck5wcERyaFg5Sm1oQm1nMXYyeXdIMU5YdTFpRGZQMUJBdwpLZ29rdDVmNVVhUkY5
 c0FBNTN2V0V2YlVVTjllZXNGR0x6UFdkSkdRNWhwZC9WSDVJUXk5U0JyaC93SWNla3E1Cm4w
 a042cGJUSHhHRTUyU2kvTVZJa05UdURaM2FwbjJqbERaNHBPdHBCWEkydlAzYlBPK05pcUJa
 anNVM3R4TGkKV2R2MkZqeXp6NlhMUndlV1JZVkw1SGE2TER0eG9yMnZ1NlVQMDdwOXh6MXhS
 WmFPRFczb1lsSEZ6WXBhNFc1ZwpMSGIybEVrSXVVZlNjaWNHYmpqQXRDbFRkR1ZtWVc0Z1Yy
 Rm9jbVZ1SUR4emRHVm1ZVzR1ZDJGb2NtVnVRR2x1CkxYUmxZMmd1WTI5dFBva0NOd1FUQVFn
 QUlRVUNYSWRlaHdJYkF3VUxDUWdIQWdZVkNBa0tDd0lFRmdJREFRSWUKQVFJWGdBQUtDUkNV
 Z2V3UEVaRHkyeUhURC85VUY3UWxEa0d4elE3QWFDSTZOOTVpUWY4LzFvU1VhRE51Mlk2SQpL
 K0R6UXBiMVRiVE9yM1ZKd3dZOGEzT1d6NU5MU09MTVdlVnh0K29zTW1sUUlHdWJEM09EWko4
 aXpQbEcvSnJOCnQ1elNkbU41SUE1ZjNlc1dXUVZLdmdoWkFnVERxZHB2K1pIVzJFbXhuQUox
 dUxGWFhlUWQzVVpjQzVyMy9nL3YKU2FNbzl4ZWszSjVtTnVEbTcxbEVXc0FzL0JBY0ZjK3lu
 TGh4d0JXQld3c3Z3UjhiSHRKNURPTVd2YUt1RHNrcApJR0ZVZS9LYjJCK2pyYXZRM1RuNnMv
 SHFKTTBjZXhTSHo1cGUrMHNHdlArdDlKNzIzNEJGUXdlRkV4cmlleThVCkl4T3I0WEFiYWFi
 U3J5WW5VL3pWSDlVMWkyQUlRWk1XSkFldkN2VmdRL1UrTmVSaFh1ZGU5WVVtRE1EbzJzQjIK
 VkFGRUFxaUYyUVVIUEEybThhN0VPM3lmTDRyTWswaUh6TElLdmg2L3JIOFFDWThpM1h4VE5M
 OWlDTHpCV3UvTgpPbkNBYlMremx2TFphaVNNaDVFZnV4VHR2NFBsVmRFamY2MlArWkhJRDE2
 Z1VEd0VtYXpMQU1yeDY2NmpINWt1ClVDVFZ5bWJMMFR2Qis2TDZBUmw4QU55TTRBRG1rV2tw
 eU0yMmtDdUlTWUFFZlFSM3VXWFo5WWd4YVBNcWJWK3cKQnJoSmc0SGFONkM2eFRxR3YzcjRC
 MmFxYjc3L0NWb1JKMVo5Y3BIQ3dpT3pJYUFtdnl6UFU2TXhDRFhaOEZnWQpsVDR2MjNHNWlt
 SlAyemdYNXMrRjZBQ1VKOVVRUEQwdVRmK0o5RGEycitza2gvc1dPbloreWNvSE5CUXZvY1pF
 Ck5BSFFmN2tDRFFSYmVvQVRBUkFBMkhkMGZzRFZLNzJSTFNESGJ5ME9oZ0RjRGxWQk0yTSto
 WVlwTzNmWDFyKysKc2hpcVBLQ0hWQXNRNWJ4ZTdIbUppbUhhNEtLWXMya3YvbWx0L0NhdUNK
 Ly9wbWN5Y0JNN0d2d25Lem11WHp1QQpHbVZUWkM2V1I1TGtha0ZydEhPelZtc0VHcE52NVJj
 OWw2SFlGcExrYlNrVmk1U1BRWkp5K0VNZ01DRmdqclpmClZGNnlvdHdFMWFmN0hOdE1oTlBh
 TEROMW9VS0Y1aitSeVJnNWl3SnVDRGtuSGp3QlFWNHBndzIvNXZTOEE3WlEKdjJNYlcvVExF
 eXBLWGlmNzhJaGdBelh0RTJYck0xbi9vNlpINzFvUkZGS096NDJsRmR6ZHJTWDBZc3FYZ0hD
 WAo1Z0l0TGZxemoxcHNNYTlvMWVpTlRFbTFkVlFyVHFueXMwbDE4b2FsUk5zd1lsUW1uWUJ3
 cHdDa2FUSExNSHdLCmZHQmJvNWRMUEVzaHRWb3dJNm5zZ3FMVHlRSG1xSFlxVVpZSXBpZ21t
 QzNTd0JXWTFWNmZmVUVta3FwQUFDRW4KTDQvZ1Vnbjd5US81ZDBzZXFuQXEycFNCSE1VVW9D
 Y1R6RVFVV1ZraUR2M1JrN2hURm1oVHNNcTc4eHYyWFJzWApNUjZ5UWhTVFBGWkNZRFVFeEVs
 RXNTbzlGV0hXcjZ6SHlZY2M4cURMRnZHOUZQaG1RdVQyczlCbHg2Z0kzMjNHCm5FcTFsd1dQ
 SlZ6UDRqUWtKS0lBWHdGcHYrVzhDV0xxekRXT3ZkbHJEYVRhVk1zY0ZUZUg1VzZVcHJsNjVq
 cUYKUUdNcGNSR0NzOEdDVVcxM0gwSXlPdFF0d1dYQTRueStTTDgxcHZpQW1hU1hVOGxhS2FS
 dTkxVk9WYUY5ZjRzQQpFUUVBQVlrQ0h3UVlBUUlBQ1FVQ1czcUFFd0liREFBS0NSQ1VnZXdQ
 RVpEeTIrb1hELzljSEhSa0JaT2ZrbVNxCjE0U3Z4MDYyUHRVMEtWNDcwVFNucC9qV29ZSm5L
 SXczRzBtWElSZ3J0SDJkUHdwSWdWanNZeVJTVk1LbVNwdDUKWnJEZjlOdFRiTldnazhWb0xl
 WnpZRW8rSjNvUHFGclRNczNhWVl2N2U0K0pLNjk1WW5tUSttT0Q5bmlhOTE1dApyNUFaajk1
 VWZTVGx5VW15aWMxZDhvdnNmMWZQN1hDVVZSRmNSamZOZkRGMW9ML3BEZ01QNUdaMk93YVRl
 am15CkN1SGpNOElSMUNpYXZCcFlEbUJuVFlrN1B0aHk2YXRXdllsMGZ5L0NxYWpUS3N4Nytw
 OXh6aXU4WmZWWCtpS0IKQ2MrSGUrRURFZEdJRGh2TlovSVFIZk9CMlBVWFdHUytzOUZOVHhy
 L0E2bkxHWG5BOVk2dzkzaVBkWUl3eFM3SwpYTG9LSmVlMTBEamx6c1lzUmZsRk9XMFpPaVNp
 aElDWGlRVjF1cU02dHpGRzlndFJjaXVzNVVBdGhXYU8xT3dVClNDUW1mQ09tNGZ2TUlKSUE5
 cnh0b1M2T3FSUWNpRjNjcm1vMHJKQ3ROMmF3WmZnaThYRWlmN2Q2aGp2MEVLTTkKWFpvaUFa
 WVpEKy9pTG01VGFLV042b0dJdGkwVmpKdjhaWk9aT2ZDYjZ2cUZJa0pXK2FPdTRvclRMRk16
 MjhhbwpVM1F5V3BOQzhGRm1kWXNWdWE4czZnTjFOSWE2eTNxYS9aQjhiQS9pa3k1OUFFejRp
 RElScmdVek1FZzhBazdUCmZtMUtpWWVpVHRCRENvMjVCdlhqYnFzeXhrUUQxbmtSbTZGQVZ6
 RXVPUEllOEp1cVcyeEQ5aXhHWXZqVTVoa1IKZ0pwM2dQNWIrY25HM0xQcXF1UTJFNmdvS1VN
 TEFia0NEUVJiZmw5REFSQUFzRExjYStMbFAydm5mdEVHaHBjQQpCR1ZOUUVGbkdQckNhdVU2
 SGhOODA1V3RQVHRtc1JPdUp6cWdVVDBtcHFXSWZacTZzTXd5dkhLOVRzL0tIM0paClVWYlJD
 M3oyaDNLZmhIL0RhZjk1cGQ2bVBjL2g5dkYvT3kzK2VUV2hnR25QNmNBNWtsUitmTzFXaEc4
 VnJpWHYKck5lUkcyMHN6emplSG9jblNJY1Q1WHVaUjB1REhPaUd4T2l6MXNNUkZUR3h6R095
 MTlSOXJ2dTYzdGlJM2Q3dgpnYzc1T0NBZGtlQi9TZUNFbGFSdzBUZjdMWmJQampzRjI2M0JZ
 bk1mNGtrTkVLdnFXY1UyaWNNcCtxZXpqeW5CCnB2ZXVlMHJDVFFCWUFRbG9GQ1ZUR0hyV1dB
 NkQ0VzVPMkFmSWRJYzF1MUpDWnAyZjVMV1ZvVUZUVklyUW5RUVUKU0hDaWZyOU1aeExUdFBK
 ZFU1Mm9TUHczZGs0aExQOGlKSUx1dnYvYXZhakNzUVlIRXR3WXNiZUZaeGl1TGdscApBN1lj
 Sk5ObXBnQ3BNRDR3VWh2bEN0QUtOQlFXeXIyOTc2OThFUVRuNDZlQmVVNkttMkNpaFhrZ3dD
 eWY4ZXlLCkxFM3NYZXdhcTVrZ1pXdk5xNml1NXFZSVJCOXl3K2NYYzYwZE9aRE9scTkzWDVT
 QVJZemFvZXBrSHo0cmtMa1AKUG8rdENIeUhRUHNHblBYYzlXVDgwREM5Tm5KR2R2VWx5NXJk
 TUk0eHBaeWdlb2tqd293VlFsUFV1Y1M2TXluNwpmOHc4Y2dmQjdDMklBSWNEeDJwUC9IendY
 dmtDT1FOQTdtVjFsTTA4bitnVmtUcnpweGlwNURicTRDSW9ZeDJNCkpaVDhiR1JINlhqY1VE
 S2EwOVFoeVpzQUVRRUFBWWtFUkFRWUFRZ0FEd1VDVzM1ZlF3SWJBZ1VKQThKbkFBSXAKQ1JD
 VWdld1BFWkR5MjhGZElBUVpBUWdBQmdVQ1czNWZRd0FLQ1JCVnhETFBjVk1NamNkc0QvMFJo
 QXN1UVlPeQpyMTNCbDNOaFhrWUFaR3AyWkZER3VrZTdPU2tWOG9qT09UZFR5ei9jT1JHQ2J5
 ZEQrRGd2cUZ5VmRuT1hLZ08wCmxKbUd3ckdlTGRnZ0F2aDBpaHJwNU8wWVVKOWJCU1htR01t
 UVRZSC9BbUxUR2FkYnVqQ1dqNWZGVWtDeXd4aW0KSHV5MFBiMjRwelR2UzUwR1k1WStxSDBG
 SE5haWdka2tpV04zcnVnN0haRXUvQ3lsUFpqT1h6K0QxUVBNckV4dwo3ZC9NS2FiVis5YU5i
 UVlabGRJajk4UXd2VUYxS1N6YThqbFVJdnBoUnEyN0FUOGZER1lHUGZERU1nMmNCT2FlCkty
 N29uUXM0YjdhV082aWZEbHhRVHB6c3pvK0FuODA3Tk1TdFZFRmYrczNBaFZEM2U3bmY4SkJh
 dmJWckFlMGsKb20yNm96elBubnh6K2xxVlZ0dzZVazRYTUl6dGl4L0h3SFl3dUNuY1VYWndL
 MEkzeUFKd2pZd29vck9DaEozUwpFVWJKUVB0R3NneFJERXhWQkZlNk5MUC82MnhQOU82dGFj
 d09kYjBNbVAxYjM5cFJBVEM3YmdkMWxkVUxpNzVaCmxKckowL1NpVkVyb3FOWXk3OXRmbWdB
 WjJVeFptczlTckV5Nm85UVNmc24xYVh2K01QTDlKYUNHbWtQNnpiTFEKTm5kajBKY2FRbmtD
 MHZneWRPMUJtNk11OTZQOXVmbEtaY0FTNndtTE01SWRIT3lqTDg4d0h3anVjakFPQnRjdwpw
 MG9HVG5WT25Sc05ZU084VzhZWi9LZGJ1Nzg1ZGF6TXFKMmlOakFEdUJiZG02TjRqNUVkTW5r
 TG4wQklmUEpwCmRnbTR2bDJVcExqd1JHci9NM3dtbTVwdnMrNnVCN2hrL0ZKaUQvNGxsRU5Q
 NGVNMWg3U200aitWcTZOMSt6VEIKSVhKQWViSXFhc0RwNXlaUzdYcnk0STM2bjg1WEVZZkcw
 MWx0QXlob05WMkRPOFNJUlFwdWkydHErOVJQM1JLMQpKREJ4eEVKWTJFTzVKWjhNeGFQSFEw
 RFQwNWxSRmpLMkFsaGRFSXRqTGpwSjNmVW05c3FMeE1XeHpQNlV6M2lpCjJ1YTR1bnJ0Nk9D
 VHFRd2lqRi8zYlRXaXd2VkFBSG5NRlVpb1hzaEhhb2hWRGNWZm5lSU1mVjBiUUNYWWkzTnAK
 WTB2MFp3Y2lGSCtnU0M3cUQ2WE51aHBWR1NMNElpbGlGeS9TemNhSkV6QUhlTERTaFpQMkNX
 ZG5DNHZnbDM3dApocHg4aDU1WWhKbjZIU3VVelBnaGFLdFZCMmsrajdaZXlaK1NGeHA3SXVi
 SEN3TEhsUWhUNzVSd1EzaUF4S242CjBxajUxY1lUbnF4ZFpYVzZmSDNQa3VNellVNUdwcVIv
 MU9sNWMvd2ZJNmc2QW04eUtXLzBFVUx0K0tuNExGc1MKbTdZM201SDV2MTJVNkpCWXZWK3Ix
 M2paaW9zNEVFREU5M0Q1c05IMk1JeVJ6Q0RxMXpkZHQ0WHV5S0ZqUEtXMQo5aWJaRGZGVjdL
 dUNzdnVMMjNzQmMxc0NNb3ArRTFtVC9ReE9JQTZvRFQxTVFzdHdPVnVReURDdi9PdktTZ2Z6
 CjhGWEdMNkFQY2xqQ3FqOEFKaHhReXN4ZG9pUVA4bS92dStialdHR3Z4dzVzMWxncGlSRFRS
 VVBnY0pKTmFHWTIKVklEclpRaTROU2lOUTBOSWkrZGp1NGZOTW1DcFFxZzh0YkMzY0FhNnl3
 bTZvUUIxU0JobURYMmUxMWdSbGx1SQpPblRHUEUwSFRvM2w3MmxoYmc9PQo9cVpNVgotLS0t
 LUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
Message-ID: <e22d5757-92fa-1371-44cc-fa2cf172ec70@i2se.com>
Date:   Sat, 7 Aug 2021 11:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210807002722.2634585-2-jsavitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:wR7Et3RhlaHxCOFHZrBCQh0Z9k6iCQ22yYKpHMNVY/KzMhPj0bE
 7WYAXqKOJQSyh8mhwfQjAlsk/iQwog6JMCM0xnBLeyDAav268ya9qDvjCKSkbb1EMq2HFlh
 Nph4UVkTXhzseSkv7V2+AwdKwpoiJjriBJqajFc5BZlfPDYZP7p0/CmJDlgg3fwAuAVCXB8
 7ZCCJZ9D0R+FJhSv7RnAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RfXibWqS7ww=:Ls9fbLZ7UQWuKO6AyvmNZ4
 9wPJGOSImLoph5Uw1QIODkuuG8VlJGNh66hMVotxeYCxTlL+XNvCro0p+qOE/Q+bSIUIN3YPn
 Q6m4iHj+KJgLPlvQef//XdiSJ8Un8Ajm/xVszI/fDnnxodv1VeYioIrByV307JCH0vx1CsK7x
 0praBqQk2hVyMwpMczJui4oGz+kj3JASWVVCK0+5iJf46BRa3Yn071k81d6ADUwo72bTLsd8U
 IaZrzGBaYck2Zv8lYOPBoxmq6j40BhXDGJLB5Of8Qswa4Ro9luDb0n7+IoTvEzqa/9Hbs6cZr
 fCJ3Jp7RIdzsmBIWrg8VYZ5uBTzUS7/YMN98WWmhnkWfMZJ/TEic23JLaOBiGERvWzYyp1/L3
 k0vcjz5J92OseLzX2aGA9Gv/3ACKWkxWg5vsF2iGWCs5QToCo+dsb6Z+4k8o1md0Dbxldng5i
 3v3apO9OHa0yee+1of4UAN8McKyORv/3FNyjL4tykZs3dDZlYb9PuWmrmIC7A13yHdD1HHkmA
 ieKnak88mXne/3M0Eyak/PIpWUNTAP08Q1H6BM5tnCT0lplQnoeK+/Jp9y5o9S4ZJLaNhUy3r
 CzY2wyTTRFrzcn5FvcI3prEfJLLowedhFaBxkrL/W+IWy6nCSSa+k4QIO2RtL53mPokdldAhf
 a1LQb5tx0twGZLuZe2y1PoelN1KqN3E8AHxfBVJSSfwdj18QfVEi8N2gLPr0J/epLzgASw5Cr
 AlEV4Ky58N2+twuhuZjsp+Trl0shHG/6qehA2+VGDhVg7kg105TzLnenOd0L5muXjo+sbwV4y
 DPDfGugOPQ+UdPHXqhIZ/WDphc/8xghW72gZBbaquFFnyn6zOimHOCoEpOCUgkKMY/YOQHhEI
 RrmXuiUhI/aUynExpD9A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.08.21 um 02:27 schrieb Joel Savitz:
> This patch adds the core driver file, containing methods to communicate
> with the board over I2C. We also add the header file shared by all
> three drivers, containing common data and definitions. In addition, we
> add a config option to toggle compilation of the driver.
>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  drivers/mfd/Kconfig          |  10 +++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/rpisense-core.c  | 170 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rpisense.h |  55 ++++++++++++
>  4 files changed, 236 insertions(+)
>  create mode 100644 drivers/mfd/rpisense-core.c
>  create mode 100644 include/linux/mfd/rpisense.h
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6a3fd2d75f96..614de080dee6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -11,6 +11,16 @@ config MFD_CORE
>  	select IRQ_DOMAIN
>  	default n
>  
> +config MFD_RPISENSE
RPI is not used before in config options. I suggest MFG_RASPBERRYPI_SENSE
> +	tristate "Raspberry Pi Sense HAT driver"
> +	depends on I2C && GPIOLIB
> +	select MFD_CORE
> +	help
> +	  This is the driver for the Raspberry Pi Sense HAT. This provides
> +	  the necessary functions to communicate with the hardware as well
> +	  as a joystick and display interface. Linux communicates with the
> +	  hardwire using the GPIO pins via the I2C protocol.
> +
>  config MFD_CS5535
>  	tristate "AMD CS5535 and CS5536 southbridge core functions"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 8116c19d5fd4..76f9a9221241 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -263,6 +263,7 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+= rohm-bd9576.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
> +obj-$(CONFIG_MFD_RPISENSE) 	+= rpisense-core.o
>  obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
>  obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
>  
> diff --git a/drivers/mfd/rpisense-core.c b/drivers/mfd/rpisense-core.c
> new file mode 100644
> index 000000000000..69e3051a4be0
> --- /dev/null
> +++ b/drivers/mfd/rpisense-core.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Raspberry Pi Sense HAT core driver
> + * http://raspberrypi.org
> + *
> + * Copyright (C) 2015 Raspberry Pi
> + * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + *
> + * Original Author: Serge Schneider
> + * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + *
> + * This driver is based on wm8350 implementation and was refactored to use the
> + * misc device subsystem rather than the deprecated framebuffer subsystem.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/rpisense.h>
> +
> +#define RPISENSE_DISPLAY		0x00
> +#define RPISENSE_WAI			0xF0
> +#define RPISENSE_VER			0xF1
> +#define RPISENSE_KEYS			0xF2
> +#define RPISENSE_EE_WP			0xF3
> +
> +#define RPISENSE_ID			's'
> +
> +static struct platform_device *
> +rpisense_client_dev_register(struct rpisense *rpisense, const char *name);
> +
> +static int rpisense_probe(struct i2c_client *i2c,
> +			       const struct i2c_device_id *id)
> +{
> +	int ret;
> +
> +	struct rpisense *rpisense = devm_kzalloc(&i2c->dev, sizeof(*rpisense), GFP_KERNEL);
> +
> +	if (rpisense == NULL)
> +		return -ENOMEM;
The more common style is: if (!rpisense)
> +
> +	i2c_set_clientdata(i2c, rpisense);
> +	rpisense->dev = &i2c->dev;
> +	rpisense->i2c_client = i2c;
> +
> +
> +	ret = i2c_smbus_read_byte_data(rpisense->i2c_client, RPISENSE_WAI);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != RPISENSE_ID)
> +		return -EINVAL;
> +
> +	ret = i2c_smbus_read_byte_data(rpisense->i2c_client, RPISENSE_VER);
> +	if (ret < 0)
> +		return ret;
Not sure about all the error cases, but i think the last two deserve a
log entry.
> +
> +	dev_info(rpisense->dev,
> +		 "Raspberry Pi Sense HAT firmware version %i\n", ret);
> +
> +	rpisense->joystick.pdev = rpisense_client_dev_register(rpisense,
> +							       "rpi-sense-js");
> +
> +	if (IS_ERR(rpisense->joystick.pdev)) {
> +		dev_err(rpisense->dev, "failed to register rpisense-js");
> +		return PTR_ERR(rpisense->joystick.pdev);
> +	}
> +
> +	rpisense->display.pdev = rpisense_client_dev_register(rpisense,
> +								  "rpi-sense-fb");
> +
> +	if (IS_ERR(rpisense->display.pdev)) {
> +		dev_err(rpisense->dev, "failed to register rpisense-fb");
> +		return PTR_ERR(rpisense->display.pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_device *
> +rpisense_client_dev_register(struct rpisense *rpisense, const char *name)
> +{
> +	long ret = -ENOMEM;
> +	struct platform_device *pdev = platform_device_alloc(name, -1);
> +
> +	if (pdev == NULL)
> +		goto alloc_fail;
> +
> +	pdev->dev.parent = rpisense->dev;
> +	platform_set_drvdata(pdev, rpisense);
> +
> +	ret = platform_device_add(pdev);
> +	if (ret != 0)
Similiar as above: if (ret)
> +		goto add_fail;
> +
> +	ret = devm_add_action_or_reset(rpisense->dev,
> +		(void *)platform_device_unregister, pdev);
> +	if (ret != 0)
> +		goto alloc_fail;
> +
> +	return pdev;
> +
> +add_fail:
> +	platform_device_put(pdev);
> +alloc_fail:
> +	return ERR_PTR(ret);
> +}
> +
> +int rpisense_get_joystick_state(struct rpisense *rpisense)
> +{
> +	int ret = i2c_smbus_read_byte_data(rpisense->i2c_client, RPISENSE_KEYS);
> +
> +	return ret < 0 ? ret : ret & 0x1f;
> +}
> +EXPORT_SYMBOL_GPL(rpisense_get_joystick_state);
> +
> +int rpisense_update_display(struct rpisense *rpisense)
> +{
> +	int i, j, ret;
> +	struct rpisense_display *display = &rpisense->display;
> +	struct {u8 reg, pixel_data[8][3][8]; } msg;
> +
> +	msg.reg = RPISENSE_DISPLAY;
> +	for (i = 0; i < 8; ++i) {
> +		for (j = 0; j < 8; ++j) {
> +			msg.pixel_data[i][0][j] = display->gamma[display->vmem[i][j].r];
> +			msg.pixel_data[i][1][j] = display->gamma[display->vmem[i][j].g];
> +			msg.pixel_data[i][2][j] = display->gamma[display->vmem[i][j].b];
> +		}
> +	}
> +
> +	ret = i2c_master_send(rpisense->i2c_client, (u8 *)&msg, sizeof(msg));
> +	if (ret < 0)
> +		dev_err(rpisense->dev, "Update to 8x8 LED matrix display failed");
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rpisense_update_display);
> +
> +static const struct i2c_device_id rpisense_i2c_id[] = {
> +	{ "rpi-sense", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, rpisense_i2c_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id rpisense_core_id[] = {
> +	{ .compatible = "rpi,rpi-sense" },

The vendor is raspberrypi, which is already listed in Documentation
<https://elixir.bootlin.com/linux/latest/source/Documentation>/devicetree
<https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree>/bindings
<https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings>/vendor-prefixes.yaml
<https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/vendor-prefixes.yaml>

Not sure about the compatible. It must be added to the bindings, but
unsure this should go to Documentation
<https://elixir.bootlin.com/linux/latest/source/Documentation>/devicetree
<https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree>/bindings
<https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings>/trivial-devices.yaml
<https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/trivial-devices.yaml>
or a separate YAML file.

Best regards



