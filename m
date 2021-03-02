Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C47032A0A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576281AbhCBE0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:26:55 -0500
Received: from sonic309-22.consmr.mail.gq1.yahoo.com ([98.137.65.148]:46377
        "EHLO sonic309-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379151AbhCBBMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 20:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1614647480; bh=vA9wWjDn6bLma0CuAY4qp6fi9IxIzOHwRVYPhrr5f6E=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=IQKE93ADVpodm7E5Mr8ZnicUu4FLDPN0ShuKQDcSTeAOjmNd30ihh27xePbPcCjmhR+biSK5G6l73E5SBXzZBkDY+hYCB+lrltjZq9Y3wGEdU2863FQGFrB8JgpZCeoq5zf+SzJ4G2Hm7Seji28D2pSMX23Iu0MdNeBQNpO6dnCjgB0fq8dWi0XCib+nQaD1KxGoHX4vEZV9uVDYqdOVYEHIg81Wc7Vp1NHN2OvSCPyQmnzH+OEU5CT5Cz8I+pMzVZpDWqd18A0tB4NftfIJtjoOObSAfIX/W4Qf29a3LxI8O/xAbUayx4D08FyZtBgEhRq441fiLjhiaR678jDe+w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614647480; bh=lPZvnkcXD538C3ylpxIs7s7ucwIgeonpNQlnFICn+nM=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=na3+khvw2jh9WZWwXP1zhONYoNWupkUIsDe6aW/AFoGrSyw2KFVvR62N/34lK3lk0CDhUgIcs/yz9u/Y2zL5NSOlf20Unue1iHGm8iJQUktxPGcr1Qhgvixz5JH1dH/Q/LUzI9NzRM5gySt6j1KRJrCCgdIX7/hrDMNPrbCZiH8WPg/w/yUtTaOwHmjQt0VcpcOyQy8lCVGBi/LD1puxYIFYENQM3dFhQ4dBge3VIXBdUjIsnVebuh/+uqgbUStl3AHMLsMeCkNVpw6+vY8cy2Gi1dRY5XaRdTy9HLQrfjHHQdMSNE1S8G8D9y/NKRqaTzpCXVs9f7VMRd+vr77QXQ==
X-YMail-OSG: bU8m3UQVM1kKpbeCirlobVfuXYiKp.RHohhdsuz6o5CAuD5e5vIT6wMPvCyWFo7
 vPB4hEp7UY9HjxnMBXe2hK8dkOfzyt8Y7xx1mUUWp2RK4pEO2zMy0Cz6z70UylQhOJ9eODe65PTy
 u1LmJ2Xxkjq9d1aHb.d9F2xMX1xjK0Uh6trEfKRj8eem7zG9NFVC2BYCIEQVm4pNPPsnLmRGdbmh
 xLw125Fh4qnn1DsaetCC9KYIAC8rFSmpTxvWj191Vc4cnht.5iyXsd_YTmckKWCsud2VTsxykTy2
 _ai5_HAbPpzVh6AbIY4qHt8DboZvneaqHFdm93JX0g9Sp391pQWme4_5wqa8dQrbTAKssr_cluGx
 .95mW1Q.WpAGdV__oXvGlpvvM4J9jqQZXWv21fFqG2Wai__wrubu_S88mp_ntLoaNb7_vruqQ6NH
 cqaHverwIUS3GxCOZBZlH.ZrvNgcmUS6cJ9AjpFylvkvipmt4sJCpPjZDvyuh1W_RT.ZqZQglg8k
 NJQOyKpBmgd.pxG1gwUNmjhRMzg.nntQGw34WipMX2UvX34iZ7u5AiAMiygZkS78MpLDNyis5YNB
 moo6zqgueIAynTssHuIGus_rf1nuNM.pnAu7rrXo9ns1jNwdRN7tjASrTL4F0IhZdB9feDt6XY68
 3rVyTgcMmaF9tdgSjjR7Y6CQGSUfcqbPr8WUI2HU2OhHxWNkyzxepYj4u32kRtGT1yKffdZsfUev
 MMJ0GxHv0tiJSyenXMCMF9X1sSyV9s99uv.cWZ2AS93HY4BMZqzBYRBUL_PaGcMVRgg0reH5P_YL
 FR_UAn5wft1VaRRMvpJmIx9XSKst3yxjy.Iq3QZLBMd16eOOexoNMYUM3H4sTNjFeX5ugmwNYUw5
 7yNPPol0qCgw0BmUPdz1CuPQjCDkmMU4.jNwKmGZb37Lxdwn67lQp5YmYfq8ctjIkzsilVOmrKX.
 9C8i82dMQkkhYwBxobR7_HTb5C.uvDUDW00XIgCqOeSrGkZHyddOlAhzRrULnilP.iO1sJa9kxt4
 LQCY4RJSh1vOBvGqVd6oOhLolx2whfMJJ9O93XBly8Dkvnn9T2i8pDioKYcpOuDSqCUqnRS5m27A
 DR1qbiFT2mvpoBTr1YMR8FTkybphjDX9TBFDjKX3XridXL9eVAy6mVuQI7altDgARTk8ddli9Zqa
 amehohK_rDrpkE1Z3KwFYjMenq8UwboEHnQeE76KyF7O_JoQMxa_kvxdiPuauU__GI5fUulE0qbf
 Ph.vlm92OWPtlDZkwXu1BEyx6CGcLnONhc6Gte2N2ybqsbzVc8lf2iGABQ7wIu4_irtLTI_ObzmC
 gZnnDgatVKgBKNpDZgM_tq3kYDm9Mlg3uRSmVkqo7vtpdkwkcoiWismHm3q1JJT_FjXO_zj.uKPO
 l5lt8BIIWbg7U_RtdqxuA6pZq1kbEZcEsOoos84H9sOHikn07Z0Q9Q6WVoVoUudfzwkZiEetmYBZ
 4adhXf4SoqgYFpXic2J_b0ivczjsvjPsBssw1ZwgUJKQqhlGnpi4jd0B2iaRfVeE2d1LYMTd1pLV
 7b4avpmoWSL3NDau5qJb1eJyLi.7r.0qVFuRBNN7.CIFjT1rQBVGmEcYsNE67f7H8w_63wxLkLqs
 pyHOUMUD3v6Bvo6szhCxcGtgttwvpCCXlc_EPVqcIvEcOUBd2CTs6zqAfpx1hAY_x5Xq2HZnEiui
 IiHpG69uFthhkey9YeHwkxlbjXuOI9bgliTTHD34datZOrxP.2Vf02mr6ca87UO436qJ4YGTC7So
 Th2flvtlHqcCQVp6szXdsjzouDCdI3viofyN1BNyCrgcpVwudfSaaEa8Kt9GgUtbZ4qZfoIkoU9R
 ID..kDb62fO7xAa0IA.Ur8XBxFFDgHzYzw_yW_cgjmxMOuG3wuuTt9JbDDb82XKXf6S9DUcoQSod
 YMFw3vEuc0WxJtX_nmgdMHooehztOGRIOYYBjMBGgkm1dyXnotYMEjzXZbT7.aDoLVN0jdMd_YU7
 Z4B46gYmlzlZoRsxJsZMRFKyf6ag9iIUNIUFSa86Q5i_I..Dc2116GhY68tnfqO6QQ49rpHhFzfx
 Z7L4Yhw0hNk20r0WfCVIs8omp0I.CqbV.TJ3coe_E6xaWeuci1nWeBVqiSlAhz1D8XH877KfQ0o4
 lvgcnUtK57jLwwQnBAlz9a_e.nGEeG4WD0ox0kneaGVpm41OpRXS.kGHYg0iRce.Ew66MqMRJgXR
 j8dFgYrEeMNGEfDt0z8.kmVHOBcrdbwAPsUtwl7cx3z9KxtMr99FgO3UGBsl3TednBbxka9.NG_o
 KEmn4.RGxoCRNDj5BQtzDVFHS2WQwRupea2Roff8W207FhtygiYxFzQKTdBhDeQxr5.XjYrBLqG.
 S4vLYgtM1WFLWBsjl.tdUfdoB1F8YZo6hXgRsrIE9dcI04qMmcGnCuvtHJkStx_64ZU6OiDoD99X
 Kxa56fAkyC.7WgMpPnIDey8zZC6HLFo3gH__cd2FXcRcLBbcmBguDX8Wtfl_WJurW0lw-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 2 Mar 2021 01:11:20 +0000
Received: by smtp401.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1eada59726444d77940edec9cae3d9d9;
          Tue, 02 Mar 2021 00:57:50 +0000 (UTC)
Date:   Mon, 01 Mar 2021 19:57:46 -0500
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: 5.12-rc1 regression: freezing iou-mgr/wrk failed
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
Message-Id: <1614646241.av51lk2de4.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1614646241.av51lk2de4.none.ref@localhost>
X-Mailer: WebService/1.1.17828 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Linux 5.12-rc1, I am unable to suspend to RAM. The system freezes for=20
about 40 seconds and then continues operation. The following messages=20
are printed to the kernel log:

[  240.650300] PM: suspend entry (deep)
[  240.650748] Filesystems sync: 0.000 seconds
[  240.725605] Freezing user space processes ...
[  260.739483] Freezing of tasks failed after 20.013 seconds (3 tasks refus=
ing to freeze, wq_busy=3D0):
[  260.739497] task:iou-mgr-446     state:S stack:    0 pid:  516 ppid:   4=
39 flags:0x00004224
[  260.739504] Call Trace:
[  260.739507]  ? sysvec_apic_timer_interrupt+0xb/0x81
[  260.739515]  ? pick_next_task_fair+0x197/0x1cde
[  260.739519]  ? sysvec_reschedule_ipi+0x2f/0x6a
[  260.739522]  ? asm_sysvec_reschedule_ipi+0x12/0x20
[  260.739525]  ? __schedule+0x57/0x6d6
[  260.739529]  ? del_timer_sync+0xb9/0x115
[  260.739533]  ? schedule+0x63/0xd5
[  260.739536]  ? schedule_timeout+0x219/0x356
[  260.739540]  ? __next_timer_interrupt+0xf1/0xf1
[  260.739544]  ? io_wq_manager+0x73/0xb1
[  260.739549]  ? io_wq_create+0x262/0x262
[  260.739553]  ? ret_from_fork+0x22/0x30
[  260.739557] task:iou-mgr-517     state:S stack:    0 pid:  522 ppid:   4=
39 flags:0x00004224
[  260.739561] Call Trace:
[  260.739563]  ? sysvec_apic_timer_interrupt+0xb/0x81
[  260.739566]  ? pick_next_task_fair+0x16f/0x1cde
[  260.739569]  ? sysvec_apic_timer_interrupt+0xb/0x81
[  260.739571]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[  260.739574]  ? __schedule+0x5b7/0x6d6
[  260.739578]  ? del_timer_sync+0x70/0x115
[  260.739581]  ? schedule_timeout+0x211/0x356
[  260.739585]  ? __next_timer_interrupt+0xf1/0xf1
[  260.739588]  ? io_wq_check_workers+0x15/0x11f
[  260.739592]  ? io_wq_manager+0x69/0xb1
[  260.739596]  ? io_wq_create+0x262/0x262
[  260.739600]  ? ret_from_fork+0x22/0x30
[  260.739603] task:iou-wrk-517     state:S stack:    0 pid:  523 ppid:   4=
39 flags:0x00004224
[  260.739607] Call Trace:
[  260.739609]  ? __schedule+0x5b7/0x6d6
[  260.739614]  ? schedule+0x63/0xd5
[  260.739617]  ? schedule_timeout+0x219/0x356
[  260.739621]  ? __next_timer_interrupt+0xf1/0xf1
[  260.739624]  ? task_thread.isra.0+0x148/0x3af
[  260.739628]  ? task_thread_unbound+0xa/0xa
[  260.739632]  ? task_thread_bound+0x7/0x7
[  260.739636]  ? ret_from_fork+0x22/0x30
[  260.739647] OOM killer enabled.
[  260.739648] Restarting tasks ... done.
[  260.740077] PM: suspend exit

and then a set of similar messages except with s2idle instead of deep.

Reverting 5695e51619 ("Merge tag 'io_uring-worker.v3-2021-02-25' of=20
git://git.kernel.dk/linux-block") appears to resolve the issue. I have=20
not yet bisected further. Let me know which troubleshooting steps I=20
should perform next.

Thanks,
Alex.
