Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4103275A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 01:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhCAAx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 19:53:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15546 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhCAAx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 19:53:57 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1210m88Y025447;
        Sun, 28 Feb 2021 16:53:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=yjLz+bstPcvW0SxhFF0AHf4jVJ7K6kOKD/jrlVF4KLM=;
 b=L3bC6rbO8dMBKdis49/2AKyG8vpkmiYyM36UGKzXbHPAcUJb54soqJS5hn3GC7oT4IUj
 pL9R4zMZ+Q9k1RITqxLZcB593DDPAYTUZRNouZIdyFZlqyMIsLqrQVCM5Km/wBjQYGTd
 CItrt2H2Ww7DVJiiTLGahj9q7VvUlC4Be7U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36ymsrd74e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Feb 2021 16:53:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 28 Feb 2021 16:53:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9rR+3PLV8d6rw73CyGf7xpvA6YdkgJb79vyMPJmQfQx7vNBKlHPAtOe9z1oUPz7xEYfXDEq9/Ic4QOIcCFdGBD6BHEZjcpzBWCc57TZ0Al+f/WhDpz3fTjGwtaZQgvR0jcadIrZEe2qQiEnGZ4Ihc57qRy9xzdpFqj3OEfiQUfo5PU9JvHYtucJwEdbmc5tOk/He/RcaMCf+Zoumb5/EXAUPjlc+6o5hYoYkRsVgl2FiY31WpAkZ7KI5HWkG/6nNS7jLm2m9Ll3+NiwsmT04Lihejk/D/4ym04BL9PNcU/rHeX40IS6JYoI/lX835yP1AVtpA5nXkiL1maYn8g8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjLz+bstPcvW0SxhFF0AHf4jVJ7K6kOKD/jrlVF4KLM=;
 b=hSVsVbxLDOZqD9oYep8PAmy+57Cx2AEgwu+bCoRUDXKpu0ICplaYYNf+4i2vf6iYDc5qjkLC/U7WMtx98fqCOb5KzqbU1FSH7GxPkRpsKCNClJpZY/Sk4zSKK3qdeC5CuwwUGpRABgT37GcG8Mdlvbta/oeXM4KNWUFFeWPaWHzpr+GmOFwEXmJuJo4IRDPTsiuG+h3X5Tx/UAeZxqYmtRWdIdy42ZuOhPnQvsc8cXPtBdCIDoaZzXZAfE3pHnDepBc2QOeP8RPqA06gcfdOEg5CWkQkBkG2SdMcoiNAvh+7Xr3skRy8BvZHbhm59rZkNJoV2FDcdH/JFyLk1GUAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4219.namprd15.prod.outlook.com (2603:10b6:a03:2ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 00:53:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 00:53:07 +0000
Date:   Sun, 28 Feb 2021 16:53:02 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] mm: /proc/sys/vm/stat_refresh skip checking known
 negative stats
Message-ID: <YDw67lSx5vLTgx/O@carbon.dhcp.thefacebook.com>
References: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
 <alpine.LSU.2.11.2102251512170.13363@eggly.anvils>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2102251512170.13363@eggly.anvils>
X-Originating-IP: [2620:10d:c090:400::5:8ce8]
X-ClientProxiedBy: CO2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:100::27)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8ce8) by CO2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:100::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 00:53:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdd2a830-3434-4757-b3d0-08d8dc4c60c6
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4219:
X-MS-Exchange-MinimumUrlDomainAge: kernel.org#8760
X-Microsoft-Antispam-PRVS: <SJ0PR15MB421957B60543AA874A560B16BE9A9@SJ0PR15MB4219.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oy0nRhLpKMHZATweZzLldqkiNKA5dOq/JajhPwguUDo4+3z/WAA5pGg11VDLRySEQSq2045dcRQ1qVaKHUP12MuUFdBnKuqVrIlIc57GOLOW2ymqKxJMjzN3//eXip8uPMLqRDQPuLaO4GWgEp9pddLMxOkqRV2XfBXtqqTW631xd4N/Vyy31WwX04zTfM3NWWqOUyz790uj7QLvLqJkBLLwWGOo7dexy72BUKydbfkJdJ2trg0vF1PEzH5MrECq9UOVtTXwObB9W9jrkN5ZRxABtThqbGXwO/3gE+/+q7KTG42m254DsLXPj2UVEo5+Rs9Q0mfMojvgtHT0HqWnZdOcmuuv2dWxZeRof0gEcvrb4sahjl297zO9jw3drYdxHDJ+meuRSeYe938oKiAeFIwqZY0ZBxF/FvtQcnt1E3CwXacewUDeWP+5HmvR0Qht7V6NP2mYeTVTYbOl+RWWXn/LlRDxfhTwNoVOeM61Gygf6zUAe5xr0mf9zeOKEsxUHvFEipmDOXW7izxcOBget5VOi4qNiKijdnVhkwjK1uQiVA8x8qK7j46MDW9y3HpQS4UOZBso71xIm3SEgDRlaJnPTLwUxvV0Zqx0+QlvcmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(55016002)(6666004)(9686003)(54906003)(83380400001)(316002)(2906002)(66556008)(7696005)(5660300002)(4326008)(966005)(478600001)(86362001)(66946007)(66476007)(186003)(16526019)(8676002)(52116002)(8936002)(6506007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xMo0XENOoAZ74jICLg8NHjx46AmI6/mKCqA809a8dQtuSscRHYCXOfyoHBSG?=
 =?us-ascii?Q?AFnyhJwSTDuYLEQTId9Z1i8D7Pvfdxxw5Csr4a19rhozFMlGz1JgdVU6TtFq?=
 =?us-ascii?Q?sN3mscNvt1ZnLMYXBzgbU6wAqRcEikABAgdvq9Jo+plrked2yxbZ2Ju/tVDz?=
 =?us-ascii?Q?5C4bha1FVmyMLA2XSkzrbJ5ZIkgvDAr3N94jqOiTemjjLtuNtoawQ4WcKjFt?=
 =?us-ascii?Q?p7hdFLGIpAEAIZNRjkd9x9U5qHCMFvoBHYlf6qSJJy3diIwFxyOOFmfUTzxy?=
 =?us-ascii?Q?6UVDyWt/bnKXZEntxUcAGht2sKgogal98DjAvUIODJDBHjucqaqzd3yw+v1q?=
 =?us-ascii?Q?D/ShovYYcA0v0am1eMdMfwrbasBaxX7iO+hMSYp660Q9sW2pqr41BFmGFXEn?=
 =?us-ascii?Q?NixmQK76x8F0dwzCphSHdUF65X4mfrJr4A/dnlw/FPRCk8MBrurt7lmoLcU8?=
 =?us-ascii?Q?+xq2K6FPbOqf6zBd1243LDF74YIMueHT7tyTZR2N1cZdVhhWwRV9OPaJL5jf?=
 =?us-ascii?Q?OBIAWFKOm5v4TNTLhPP++rSnZtkhwfM3KIZEzSsupuJiNCcva7aJUv4iD/5z?=
 =?us-ascii?Q?9LRbeQOQI89CoX7IN7vTqClfZQJIx23NT7/2urXBw/AZ22oOvGKYCCoDbN2E?=
 =?us-ascii?Q?COs0eSy6QURt610qd9Ji1HAIK6bvmDvId+IZz3X/8Y+AzXKzDWf4E5ysEUEY?=
 =?us-ascii?Q?9bn3gNZ3KR9cT4iQyvrLSe9wHLjKisjqEtTpNrs9tLOMIffBRsPWMBOZ+ylH?=
 =?us-ascii?Q?C4LRHaesaESgOM+Fa5rQzKJmZudqELy+Z9Ui2CdmMgC+fnrIFskVB98x1SHV?=
 =?us-ascii?Q?nplprKw8RkP7zJg7cFaIJHcoyUaMisNyWOV/cQp85IGV3IUI01ypuqRX0i3o?=
 =?us-ascii?Q?MXbJ1rxlbf3Nj7MsijqFrv46T8n05ywmqNNyohuFLQmCWc1RgS6tmZh5f539?=
 =?us-ascii?Q?Exk+L2HVNX0JMNXnSuQEHVSWyiFikq1PgBbzvAZ5cEasJcULT+nwYXxQ0TY8?=
 =?us-ascii?Q?DAT2TcwmIJuzF0dKfWriIM2uPh8S62ZWsWnue7DidKb49lC47MCA45eIAviE?=
 =?us-ascii?Q?DPVve3AUQ3eGMMqi6gjJmRs7bgXN+s5DIXJLHN2MSuVpgGdP6Gv/n3IgM5TQ?=
 =?us-ascii?Q?aNK5crFnjxxwnOwzav/jzhIVYCT2P7P8JuJRL8AP67ypWVAaCWNZ5hIHQ4YV?=
 =?us-ascii?Q?8WH3cIuV0bBridsL7HkIjsIOAJi8mab1kJ+vDDR6btB+N7pF3lqUvfWZoheV?=
 =?us-ascii?Q?tFxBWzcbCtU/uLmfBIlpC/1ey1CEIQ/lVQDYJ/Q51xPvKGbCeg1XAMzcsmlq?=
 =?us-ascii?Q?NueVepvEgfDSXCZK/K2kYq0piJUjWn/sH5MOjRGAboj6gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd2a830-3434-4757-b3d0-08d8dc4c60c6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 00:53:07.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbbWdC3eNsQGyKw5aSWHvNpar2Rn1El5f6lvLk0lW6MNLkJv2Ic2wq1uFSwSAddz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4219
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-28_12:2021-02-26,2021-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 03:14:03PM -0800, Hugh Dickins wrote:
> vmstat_refresh() can occasionally catch nr_zone_write_pending and
> nr_writeback when they are transiently negative.  The reason is partly
> that the interrupt which decrements them in test_clear_page_writeback()
> can come in before __test_set_page_writeback() got to increment them;
> but transient negatives are still seen even when that is prevented, and
> we have not yet resolved why (Roman believes that it is an unavoidable
> consequence of the refresh scheduled on each cpu).  But those stats are
> not buggy, they have never been seen to drift away from 0 permanently:
> so just avoid the annoyance of showing a warning on them.
> 
> Similarly avoid showing a warning on nr_free_cma: CMA users have seen
> that one reported negative from /proc/sys/vm/stat_refresh too, but it
> does drift away permanently: I believe that's because its incrementation
> and decrementation are decided by page migratetype, but the migratetype
> of a pageblock is not guaranteed to be constant.
> 
> Use switch statements so we can most easily add or remove cases later.

I'm OK with the code, but I can't fully agree with the commit log. I don't think
there is any mystery around negative values. Let me copy-paste the explanation
from my original patch:

    These warnings* are generated by the vmstat_refresh() function, which
    assumes that atomic zone and numa counters can't go below zero.  However,
    on a SMP machine it's not quite right: due to per-cpu caching it can in
    theory be as low as -(zone threshold) * NR_CPUs.
    
    For instance, let's say all cma pages are in use and NR_FREE_CMA_PAGES
    reached 0.  Then we've reclaimed a small number of cma pages on each CPU
    except CPU0, so that most percpu NR_FREE_CMA_PAGES counters are slightly
    positive (the atomic counter is still 0).  Then somebody on CPU0 consumes
    all these pages.  The number of pages can easily exceed the threshold and
    a negative value will be committed to the atomic counter.

    * warnings about negative NR_FREE_CMA_PAGES

Actually, the same is almost true for ANY other counter. What differs CMA, dirty
and write pending counters is that they can reach 0 value under normal conditions.
Other counters are usually not reaching values small enough to see negative values
on a reasonable sized machine.

Does it makes sense?

> 
> Link: https://lore.kernel.org/linux-mm/20200714173747.3315771-1-guro@fb.com/
> Reported-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> 
>  mm/vmstat.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> --- vmstat2/mm/vmstat.c	2021-02-25 11:56:18.000000000 -0800
> +++ vmstat3/mm/vmstat.c	2021-02-25 12:42:15.000000000 -0800
> @@ -1840,6 +1840,14 @@ int vmstat_refresh(struct ctl_table *tab
>  	if (err)
>  		return err;
>  	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
> +		/*
> +		 * Skip checking stats known to go negative occasionally.
> +		 */
> +		switch (i) {
> +		case NR_ZONE_WRITE_PENDING:
> +		case NR_FREE_CMA_PAGES:
> +			continue;
> +		}
>  		val = atomic_long_read(&vm_zone_stat[i]);
>  		if (val < 0) {
>  			pr_warn("%s: %s %ld\n",
> @@ -1856,6 +1864,13 @@ int vmstat_refresh(struct ctl_table *tab
>  	}
>  #endif
>  	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> +		/*
> +		 * Skip checking stats known to go negative occasionally.
> +		 */
> +		switch (i) {
> +		case NR_WRITEBACK:
> +			continue;
> +		}
>  		val = atomic_long_read(&vm_node_stat[i]);
>  		if (val < 0) {
>  			pr_warn("%s: %s %ld\n",
