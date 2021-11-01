Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4635E442064
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 19:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhKATBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:01:02 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38237 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhKATAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:00:54 -0400
Received: from [192.168.1.107] ([37.4.249.122]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmDZI-1mHKA51w7E-00iFbD; Mon, 01 Nov 2021 19:58:01 +0100
Subject: Re: [PATCH 1/1] staging: vchiq: Replace global state with per device
 state
To:     Ojaswin Mujoo <ojaswin98@gmail.com>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1635764115.git.ojaswin98@gmail.com>
 <5b51970f601c4bf5165fc70174085a809b3c0316.1635764115.git.ojaswin98@gmail.com>
 <84300618-98c8-0f44-e5a5-8d7fd6c853b0@i2se.com> <20211101172843.GA17771@ojas>
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
Message-ID: <e3caf226-2133-c570-b775-17ed3c7fbd02@i2se.com>
Date:   Mon, 1 Nov 2021 19:58:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211101172843.GA17771@ojas>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:y0bjRSrOsPdSspXGsXQwRqH420+jpCSJXdzQUwWWOyvFCOXgZnA
 e3GAkdtT5lvBq60qPKHy3Regk46ANTPb+MFBzpAPlQUfAmZvYTrthjLTJPKXi5jSV6XOGc2
 k2u8tgGE+Vv5Mx1p6YG9LDTxd/ebJy1x+emC7tsCuh1uUu4DPlq9CixXNwnEJDxJQqAibmK
 I+6Avz6y1SPCSxapYuUPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VFTS3MQp5Tk=:izNR7/Kj0F3D91+rN7e67f
 il14sBbqBQirx2sGF8pzUtdmBAZQh6R4T4v5zYBGSlpqrIYDIfbxYSgWpJ8ZeZPXadQr0BQLW
 xM7qGslNW5hj6fA0up0A7IyamGqCWOLeEC1eAUgaT31jN8eO9xCvoJ94y1+pbLSQj0c2PoqCa
 2/mCMvfMEnravrz1IG0UcwpykqeVXAXsGWpSyy0rgvnV+ipJAVZtjtu6c3oeAIV4yWfci1/+3
 z2oj7wynWz6+LnmNpE6N5jgrM1oXWGLPbcHhzWVmVi7T+f2LWrZUKYQUCARIU2G5SYgykQ9xf
 VODKY7V3YW/uedWwMyeb6Kbu3UqUBrTY2eeKBoJejKvyjz85bmfTHqyVVF4Jh48yVN00rLdVQ
 Kv9z9ggeXzp4erOkICvEM7na/U0Rd7cYMBT7+lePqTtm0gfwWzpEA+xYTlxs1lBEJZEbK6uWM
 N5nxxepMkHMq0IfI6kQTP9ChvKfN7PaWXRmGnczhicr2Tuhxz+dbPPc2OC40ujbCVJUEN697c
 FJwUBPfXpBeqqtU9tOi6yerQn7AHAfpYnIc2Qxmc/rI6Zt7orvtPbyBQpZoMVJeTlktkR+WMR
 6kxUQyV0brUJx/TM42I4J2tBYQPmXqeuPHapQ/pgRJvTEEzXjGV3MQkq+KweQxyjbXY0lQg7K
 FzIOA4XF2ddbHsCH33DopQrE1LqxllhKiz0E4W5kRoifmpkMJsTzL0RajKzyb91QGppfG2TGc
 Ug/X7pguQ9PEkimR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ojawin,

Am 01.11.21 um 18:31 schrieb Ojaswin Mujoo:
> On Mon, Nov 01, 2021 at 01:19:17PM +0100, Stefan Wahren wrote:
>> Hi Ojaswin,
>>
>> Am 01.11.21 um 12:09 schrieb Ojaswin Mujoo:
>>> Currently, the driver has a global g_state variable which is initialised
>>> during probe and directly used all over the driver code. However, this
>>> prevents the driver to support multiple VideoCore VPUs at the same time.
>>>
>>> Replace this global state with a per device state which is initialised
>>> and allocated during probing.
>>>
>>> Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
>> ...
>>>  
>>>  /*
>>> @@ -1763,6 +1795,7 @@ static int vchiq_probe(struct platform_device *pdev)
>>>  	struct device_node *fw_node;
>>>  	const struct of_device_id *of_id;
>>>  	struct vchiq_drvdata *drvdata;
>>> +	struct vchiq_device *vchiq_dev;
>>>  	int err;
>>>  
>>>  	of_id = of_match_node(vchiq_of_match, pdev->dev.of_node);
>>> @@ -1784,7 +1817,18 @@ static int vchiq_probe(struct platform_device *pdev)
>>>  
>>>  	platform_set_drvdata(pdev, drvdata);
>>>  
>>> -	err = vchiq_platform_init(pdev, &g_state);
>>> +	vchiq_dev = kzalloc(sizeof(struct vchiq_device), GFP_KERNEL);
>>> +	vchiq_dev->state = kzalloc(sizeof(struct vchiq_state), GFP_KERNEL);
>>> +	vchiq_dev->vchiq_pdev = *pdev;
>>> +
>>> +	g_state = vchiq_dev->state;
>>> +
>> just a quick idea: how about storing the global state within vchiq_drvdata?
>>
>> So there is no need to reinvent somekind of vchiq device which is the
>> "same" as the platform device. After that you are able to access the
>> private driver data via platform_get_drvdata().
> Hi Stefan, 
>
> Thank for looking into this. I agree that the vchiq_device is just a
> sorta extension of the pdev. However, regarding using the drvdata, I had
> some questions.
>
> So I understand the purpose of this patch is to make sure our driver is
> able to support multiple devices, that is it can work with say, an SoC
> with 2 VideoCore VPUs. In this case, we would need to maintain 2 states
> for each VPU instead of a global state, however if we use something like
> the following:
>
>  	drvdata = (struct vchiq_drvdata *)of_id->data;
>   drvdata->state = kzalloc(sizeof(struct vchiq_state), GFP_KERNEL);
> 	platform_set_drvdata(pdev, drvdata);
> 		

no, this wasn't my intention. We need a new container struct (maybe
vchiq_priv or so) which stores the g_state and the platform data from
the devicetree of_id->data. At first the probe function allocates this
struct and then we fill it with g_state and the devicetree stuff. After
that we attach it to the platform device.

Regards

