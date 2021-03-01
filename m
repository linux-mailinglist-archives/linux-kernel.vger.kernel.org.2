Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A34F327722
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 06:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhCAF2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 00:28:30 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48810 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233473AbhCAF21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 00:28:27 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1215MZci029979;
        Sun, 28 Feb 2021 21:27:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=warn61yw1Pv19Ci+GAF5pMRQW6Kb0e6ZsmXBtzNyRNg=;
 b=fnvzo962SIxIHCn2x0rogtdxDsgtlG8TRH1PXwBHtFugc6bBfOKvo1k3kSGGU/KDi1CF
 czp/VViwVAHN3UcJvA7y3lquQ0vMvKDh8EwIvvXipN9IAr25hZHwbfh064s/lJqmTV3H
 bpzXbzXTuhSXz2H20AkfRTH7h63sh7CHG6bZdZ4l8LkQAISV4HnmEdk44ePTNdv4w/94
 dN0mkrbmeL0S02XFfhfUXeGl2eWut7adRdXGgP35Dofe4Qi8c02VQDR8hMmNDD5y+tqP
 d4ojzl59x8roZWxAVCuaVnBCD7/EG5iu8CVr466xArrxQmZD+D/89PpmEzZerzx8DJOm Qg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-0014ca01.pphosted.com with ESMTP id 36ykh1kv2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Feb 2021 21:27:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2YkE5LCPMsDRYqnt/LFv3zC6UBh35l7pB8ikK6A2taBOAXCys65JSnSQn7Ql4CR+Nk7QgJNMU3jXmN8OxLYZ0+OqBtrK1F8lm3m109j4msuvKxxp4mzoVPQEy6yEweFF9lUN2X4iF58miadg5ihReo3/ZlhlwzU7gW54TgP9rFA+jLGQCqp9+r7uJNzX69WaLYcvHT/Kcg4gP4xYctuNqHv9eT92LYLAz0SaHhjY7Sr0ov1Zz3+mao/oIy3k8lllnNSHBH8MvEAmBu7gSuMcEKUqTV5kzu9V1BLXTXejZ7RYLNV7AQ7S1t69Xvo2YKKJG5peV0BWH5URUQ859OPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=warn61yw1Pv19Ci+GAF5pMRQW6Kb0e6ZsmXBtzNyRNg=;
 b=bkqz5jehQ8QD18/B4aj2PDAPpJkB0V63MZvvPpCy8GQuvu1xJz9G2P6yF/WsShCICD7pBJ9BBXC7xCso3Ecy///pup9IY4vJnpR8G/fUBWJqz/1LL2hPNaMoE74xtR+0EDphNqYL/FUAWuhhbjekKvkBensAzQHz3PqvrEDDbGL30ji6U2cKRwlOgUrZ6+tY3E0dfSz6rjcs4b5GCN/AaBq6mOdxlAyUW+Rk0aVPkvgoDDZlLDyGDMJEM6vCgwluRmhxH+p367ZQORXTvAyN/hyoymFdCXn+40Z2iBppdVeSLuTigKBUCXZqdersfu7NQurYD8eXQ3ZRdc1LUqXfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=warn61yw1Pv19Ci+GAF5pMRQW6Kb0e6ZsmXBtzNyRNg=;
 b=njjQHcnxobc2qfo4bScJXe5gKS9sdGEU6g0f0tClr1a6tjOGZQZY7Kc209XED79vfQWGIIzeJWbWlHYm2/2PgH6XSQ3JUteGNISCJbU9pHxX54lJ6ThOg3pgBGHHJXbXABZQXVf1A0fs9y9LlvndIC1DNcbdqVgOhElGqX4Lq6k=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB7845.namprd07.prod.outlook.com (2603:10b6:a03:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Mon, 1 Mar
 2021 05:27:05 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 05:27:05 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jacob Wen <jian.w.wen@oracle.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>
Subject: RE: [PATCH 0/2] tracing: Detect unsafe dereferencing of pointers from
 trace events
Thread-Topic: [PATCH 0/2] tracing: Detect unsafe dereferencing of pointers
 from trace events
Thread-Index: AQHXDT1JcJc0w5qYuUWMRV87jR61z6pssTaAgAHqEoA=
Date:   Mon, 1 Mar 2021 05:27:04 +0000
Message-ID: <BYAPR07MB5381637CFA12C3988CA06550DD9A9@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210226185909.100032746@goodmis.org>
        <CAHk-=wiWF=ah_q1HBVUth2vuBx2TieN8U331y5FhXiehX-+=TQ@mail.gmail.com>
        <20210227141802.5c9aca91@oasis.local.home>
 <20210227190831.56956c80@oasis.local.home>
In-Reply-To: <20210227190831.56956c80@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYmY2MmYzMWYtN2E0ZS0xMWViLTg3ODQtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGJmNjJmMzIwLTdhNGUtMTFlYi04Nzg0LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjM1OCIgdD0iMTMyNTkwNTAwMjEyODQwMTc4IiBoPSJCeGdXeGpZLzhNZC8rZ2VLU3lOYWt2dDI4aHM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0751c97-86e8-47fb-19f6-08d8dc72a67e
x-ms-traffictypediagnostic: BYAPR07MB7845:
x-microsoft-antispam-prvs: <BYAPR07MB78458371A27358CBD4EF36A8DD9A9@BYAPR07MB7845.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xNaTthbESmQkwydrBBnOaGGJrjPgI80QcKH4VZze8/cI3S23p90aVH+mNFIPFOX04qomAHLCS6UBa3VLmTi1w0Ebh2VrWETFCtyTdYGW/lAqIe8HkL7bJmOez97tb9W4G25id/2PJW6YxrUixoASL5wyHv7FQGLifqCynO6AJ1D/Z/k12gnY6G9B5/7viKCzdxFjxeaETmnVxIlopt+SxyxbUYOUjGAMg1L9fBwm6qFn8Rd0SbFELQRvgdOW5IgasCdxks/k9097uXUJFC4n0cci05uxTn67G92Mbp7+4alxJm/uvsX1wu8FmfIy1lgXKNl7EQVwbs1oCQ//dBTAyJQZPd/uRxBqNAyLcwTvKUSQzq3niM7sfqbUBHHop2a3JQkgCE9MGDffURSV9uwO8mZFico14Dix2n6MwFTL8o73O0Jw+z+/lA5GhDM3zmpsFK2vNcWEtXQjJjlypZggfAKFz7ANHp0XOHDa+JetQRahb47L/LTdcl3Gk58g/DrzsbcI6S2gbS22RhhMFb3FVwdZ+81EyGKPr8qJleycpkbf5nmSRZqHTi3e2CwE3gAyqeq3dQOapJ1wlNEqOUmdqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(36092001)(71200400001)(7696005)(9686003)(86362001)(5660300002)(8676002)(83380400001)(66476007)(478600001)(76116006)(2906002)(66556008)(64756008)(66446008)(316002)(7416002)(66946007)(26005)(55016002)(186003)(53546011)(6506007)(54906003)(52536014)(110136005)(8936002)(4326008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kZucoyWHBRtzxkXeiSpIeUNhUtd7zlZ4huh6pJt83774ZvioZLKWzYlgDQoc?=
 =?us-ascii?Q?JMXpf9F3We0cUJ2X0suBmJfWlvrNhhISUh1dr53Shpq5kOL5Ro1cNXbzBlOX?=
 =?us-ascii?Q?1GRxNbGNadWDjyml+cVelZgecfIXC2fPAKpRo4BUQp4o9IbYQhe2OUBrUeXa?=
 =?us-ascii?Q?ogceTcV+h1rZaG/kpEyJP2VdqwQpgCgYJNY3jOQSjD1CVME6ZKW5ZD2DBT3X?=
 =?us-ascii?Q?oFjqSlG0OAKko14u3nfD4B9mA0Fs7KMd2M/PBuUfLjRFSa33qxpK+K4dLnmZ?=
 =?us-ascii?Q?xUnGXNHxyN1U/tGGQtjI87pMVC3muC7qM0CcE8RblE1SE8+Cqkus/NeaSJZx?=
 =?us-ascii?Q?c+beFOaySI35NRcM26KmwITnCoDqH3OC/+2PkbL1z7ehQRXBofMcbABryl/C?=
 =?us-ascii?Q?2yMpv6k4L7WLSFdXuRWnr75Nx6ahQ//O6j1ZisROJgsreS2Uj2a3LfQbWtXa?=
 =?us-ascii?Q?PC9En88ELeMgpZZu/6elhx1G35/CKkj6z+CXtMopwAQw7ISzMgkuzxHm5jzl?=
 =?us-ascii?Q?kkdwZHkAGBXzhx9x0N2xqY5oUcuDWQRFIpwU6OT/y9jb+yxoAqyHb3M6Gjm5?=
 =?us-ascii?Q?uD2g7bQOEW5Wn1HZsSITjVK+Y0N4pIxxEThjvt71pGVBHWcRFsUsE6pq05v0?=
 =?us-ascii?Q?9rCeYnOAQAWD1DxNTbXwXIXTCTHY3vly0A55Tu3lJ24/8Q/mgf2yLE/41flw?=
 =?us-ascii?Q?ObSdqyJ1tE/huA7vqLcGJFTVCKYp2MnG38ompBHVD/TDINQa2T6sXB2yYkuC?=
 =?us-ascii?Q?miAlAp0G+cQSoDlbIS87S0pRbk8yVk/7Bu8SjW1ly48vINZ1hiRwbLoD95kZ?=
 =?us-ascii?Q?BLNYETfyN0x9xzMkLaAU+wNN6mUIBfclSoi84Za9U5wU+dA52os/NDByOTKk?=
 =?us-ascii?Q?vdG+QuPhu3Ftit5xit9GTt5iA5Ov4ulCL/AMGKSnS3WrOsJfLw/UB2zHkyFB?=
 =?us-ascii?Q?dRW73pdlZs2kRlrwrnIvzjbr6xp3AnmZCebEgbRvYJaeNxF77PukVgFDYXw0?=
 =?us-ascii?Q?5tsQzYytrOrkG2ccOdjIySvmt3nJqa0uJLgfiycOOkM51Anb200p9aEcCFLn?=
 =?us-ascii?Q?Ndsy5T7syvK3/hi2mudofOhWhgaaqYUhGtbD8toWb8UR7Qhpt86LxXvPq7Qz?=
 =?us-ascii?Q?M95e82klDCHrRz0ZHa9a2iX2+cv7nwk2aStZnZhzM14/LPUpAoX/ukLqt0rj?=
 =?us-ascii?Q?rwA00jor4m5OryDRBEmkdxPJg576x1djheq6qQKiiuDhTne6Cerx7OFeQIgf?=
 =?us-ascii?Q?s3wd5roEG6JEoeEe8HlLyze1weQeqhbWZVyYPw2z0Pdh+x6VxAETjA7QxMFP?=
 =?us-ascii?Q?/KE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0751c97-86e8-47fb-19f6-08d8dc72a67e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 05:27:04.9350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8PbB4YdNOPk2KViT+xdwHAaqnGlOrMZWoGqpkXkEtQW3BQ0HwR7T7roTkkurxUAYa7q6FWLqxuXz4sTDnboL16K02EO21m+Egmkz/h/X9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB7845
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_01:2021-02-26,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+ Peter Chen - Maintainer of CDNS3 driver

>
>[ Resending with an address that should work for Felipe ]
>
>On Sat, 27 Feb 2021 14:18:02 -0500
>Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Fri, 26 Feb 2021 14:21:00 -0800
>> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> > On Fri, Feb 26, 2021 at 11:07 AM Steven Rostedt <rostedt@goodmis.org> =
wrote:
>> > >
>> > > The first patch scans the print fmts of the trace events looking for
>> > > dereferencing pointers from %p*, and making sure that they refer bac=
k
>> > > to the trace event itself.
>> > >
>> > > The second patch handles strings "%s" [..]
>> >
>> > Doing this at runtime really feels like the wrong thing to do.
>> >
>> > It won't even protect us from what happened - people like me and
>> > Andrew won't even run those tracepoints in the first place, so we
>> > won't notice.
>> >
>> > It really would be much better in every respect to have this done by
>> > checkpatch, I think.
>>
>> And after fixing the parsing to not trigger false positives, an
>> allyesconfig boot found this:
>>
>> event cdns3_gadget_giveback has unsafe dereference of argument 11
>> print_fmt: "%s: req: %p, req buff %p, length: %u/%u %s%s%s, status: %d, =
trb: [start:%d, end:%d: virt addr %pa], flags:%x SID: %u",
>__get_str(name), REC->req, REC->buf,
>>  REC->actual, REC->length, REC->zero ? "Z" : "z", REC->short_not_ok ? "S=
" : "s", REC->no_interrupt ? "I" : "i", REC->status, REC-
>>start_trb, REC->end_trb, REC->start_trb_addr, REC->flags, RE
>> C->stream_id
>>
>> (as the above is from a trace event class, it triggered for every event
>> in that class).
>>
>> As it looks like it uses %pa which IIUC from the printk code, it
>> dereferences the pointer to find it's virtual address. The event has
>> this as the field:
>>
>>                 __field(struct cdns3_trb *, start_trb_addr)
>>
>> Assigns it with:
>>
>>                 __entry->start_trb_addr =3D req->trb;
>>
>> And prints that with %pa, which will dereference pointer at the time of
>> reading, where the address in question may no longer be around. That
>> looks to me as a potential bug.
>>
>> [ Cc'd the people responsible for that code. ]
>>
>> -- Steve

