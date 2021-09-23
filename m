Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92323416170
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbhIWOxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:53:34 -0400
Received: from mail-bn8nam08on2068.outbound.protection.outlook.com ([40.107.100.68]:58916
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241661AbhIWOxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:53:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5HP6a73D7q1hxiVW9laGdwe+uipOnaRIaGVocsMWzDyoGcUwdst5DN18ZC0fFstLiKpqsLr5amWAoI3hcIsh1sALgNETy9h/QhGHePgJPxXDv/KEEGL8xc+o4qDX3uQSaNjVJ+Fe1zY5y+ikz8BzNC7YoESexSaNm9r5C4kDmgkBqHSpSPEYGnctIZaFFfoLLS481vxRGKIIcT2z0eouNNyrImivU8ocpDkWrqYLz8IDdS3xRv1A6J+fQUGPFF0QPT/AkMuNYJQ0uRpt3GK7b0AWaAtihdj5/nEwY1PwtuxeU9t2dGaqb9jM+nJwkN6lNw0nYkQUlwNicM99DASjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OPRmDCdON3OSHpvJWEBI0gBBtS3EM+wNQuec4Zx8ZJ0=;
 b=O9a/6U5aiEmrL0e54kaxrf1TP3OkEaykn7hx2MiHxYX3nHkVyl0AhMaygOwqUA0doj8HTz0ZvObsHZ6tp1w/weThbQIRNr6RM8oPAfTKj/vIu2SCS32N4dgHSk+iOK9L6wGmQ7eDUAfXwjqPVgx9JKt7FwT/lyc0pnO5tEvoqa6ulYJrNLM+frS+7zuiKOmHpUn2foUyg7xLOUazF6oeUDgXyIX4NpRG0PhpLOp+RcwQI+3CbA89oiMirb1YW/GeRL27ZyG7NFoJorS+AgHN5s0vQ0ajJu6h+zQDkb18cn2r6vhSZx4Gb/IIMshvE3K1dXmA5cpVKI99t16guS5CEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPRmDCdON3OSHpvJWEBI0gBBtS3EM+wNQuec4Zx8ZJ0=;
 b=Suz9G4ka1rNDF1zzkcuoceaJO/9pIqzt1f6EUCWENspP0cbLGHUJQ8M7bj1AWd+sZfn717AAsE5SbnahAAcrzyplNuNXUuoqz7ho+iqBpKqsIKZ9/DHH13jwPSG/DyyhnavM7o07Ul2+M54ZTVDUl9Eh3BGi6dy9WWCbNZQ79tU=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3169.namprd12.prod.outlook.com (2603:10b6:408:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 14:51:57 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958%4]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 14:51:57 +0000
Date:   Thu, 23 Sep 2021 14:51:49 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86/mce: Get rid of the ->quirk_no_way_out()
 indirect call
Message-ID: <YUyUhfTfY/3KtDTZ@yaz-ubuntu>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-5-bp@alien8.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917105355.2368-5-bp@alien8.de>
X-ClientProxiedBy: BN8PR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:408:ac::47) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BN8PR07CA0034.namprd07.prod.outlook.com (2603:10b6:408:ac::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 14:51:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a9b247b-69ad-4ad5-d17c-08d97ea1b0a2
X-MS-TrafficTypeDiagnostic: BN8PR12MB3169:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3169FDFA2564967BA1BA8E99F8A39@BN8PR12MB3169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HdvaDlHgtELbHnx4VPzRTLm1jFDh+KzQWvxYWafz5AGC1Pk5CcSDbvmj8vbrExBWMdVBFv0oyhnrjqL2dDIEO7VaDs4dSTryp+DWBOe8aOl96YCpafrFe3czcVXuH4qkF3e4uAXSN49Q3vxw2lV+MPSiYY5tKG/CGCPeHtTgbksh0w/QZR7YbhoqpA5EwvJBNYw4HLYFC5AMI3lZ93uDlS5KbidBz14K8u7Qzvvr6d/xWQtqYhu4Aap7upn0dlD+IHBtfIr8Xag4Uq+nIR5dTLFZ+h174CeWTNMhx1bd3/kNxZD8Hy64lySNuF1Ke2/1UKeRbEViQduYuObRLEr/enrSeNYr7HRXDtP1kXpltP0Lid+J5s/fF/iIQWKam3aUy/kolhGdm1JmggqEPnnAXfMt8MnHt3Q3yFPrJWGQgspK4K9/lkMyH66BzSeGyem8Qrx/4Bl5qdvnmc03oJyAP2MKUuo8yok6ORMhBbQzyjPqTPV+z9o5TQb+9xShuH/1L4l9EnLUzYueOzpwDxyP+Yx7PZNY0xSvEZiFJFLwKn7grgGPLE1QvPW5bzjrYY2l4X+7zkU9BWTQWG/j0K9o0Sntglv+1hafnojkJCaKQsl6ojGszktf2uO7UYsZ4RDJ84KlxPtA31BU5Nyth3MmiTg3iUBCZmCuGxW8iLUWo5YbPDvA9RW1EPqmtARKOfAK3aqa9KKcvdQDzNzLDiN3ViXq8RskTIFLQKN3BOIrSppLtNFhDypU9v7p8mX/HIURJkqe5hQBws86Ckw6dySW649lZN7e1eE+8Q/V1+rMHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(4326008)(8676002)(6916009)(8936002)(66946007)(966005)(66476007)(66556008)(44832011)(26005)(5660300002)(6666004)(2906002)(4744005)(186003)(86362001)(55016002)(33716001)(6496006)(54906003)(38100700002)(9686003)(956004)(316002)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qIlT9yTnlYNx52IU1l05ofJVF2e3YrejUCMHLwpXFyFNeiOzUyDD8Z9DWTJm?=
 =?us-ascii?Q?F5qc1gNFLjFRw2HRmJdCpWtaikdh5up1GW6ppTV10ASngvfTiiRLZlqCM6Jv?=
 =?us-ascii?Q?SdQZzRD5fBrXSZieI5AQ0k4yfpuSLyo2XcFm/SzOIRemb2NudFG3alyT0szH?=
 =?us-ascii?Q?3QcY65UyUoXW6DMUi+fc4xkrqId/sqaFHUZ3wdAy4KLJo15DcusTtdYWFXim?=
 =?us-ascii?Q?Vm+50ZBk+26roh5LY0AvYHuZ+24/rppAKWerSIz1UHcpJ+y2SbCe4EiKDfII?=
 =?us-ascii?Q?1zBtVPCB51DW6ag7UayeKwYnzjivSgLj8JwacjG7n4vtmFpmgbVOqSUvi6Gp?=
 =?us-ascii?Q?aLfkpfU2k6/3mqZWU9U1c5yvaQFGemEx1qldHZpoLpAQ2au/O8CaH6OJ8U49?=
 =?us-ascii?Q?jUFsIeDVyiYt6mVRlA1ivNQwzxKLOrmKdE6dYg7X1s/Wn2sSQtbFaqnlXj0l?=
 =?us-ascii?Q?8HGupT0cVoYvhuVQej9Pz3xB/3i8bzzLqpWWvHCa3vegsx0+SmceLkEByiWu?=
 =?us-ascii?Q?QS/4VR6gzHuy5XJSfKvrfqPo7J+9Rvc1Zi/NJ4UVGnk2DK7qOJ+EELO5RLU2?=
 =?us-ascii?Q?t5SE/az9REKVfMheaOxI+Rh9D8gN0PLSwgJRIkhtEmwOEPl5JN7OqBpbjqiV?=
 =?us-ascii?Q?7Uor4pSwNpQwFrfs6tkPBG9ZkicKOSU3NJRQsPvuzZTXLLvhs07d7C6yQkqs?=
 =?us-ascii?Q?x7naTOMeE2JhCRoh0kLBH2jhwG1woWKrJaLeXOwckJ2QeVZXmPIyAjS3bN4Q?=
 =?us-ascii?Q?1WySyWfO9Rk22umMuld+8xf2jRscltBk+mxY/iGmo61gKy2vjkTucW50PXgn?=
 =?us-ascii?Q?Al4u95HmF++zOhuNnKb5cntplREZAzNt0uSjNUvhOz5dKdeL2+Jcvt3+40/2?=
 =?us-ascii?Q?4QvxfJzUAfPfM0WEvMafwu2emMRKe1bgj3YEODZWFDap+3aDGhcN8tbJ4Quu?=
 =?us-ascii?Q?6sxxIU+Tp2hreIm69g6s6PNO9t0hnl+NXEyBLQzJjollm30fAQnUS44+FFvX?=
 =?us-ascii?Q?Ab/XLKmf/FOb7SeiW+C52vefgxX0fuPLjdPrrKccrD22JthbGiezQTK6Z9DB?=
 =?us-ascii?Q?Iu+vimLAs8KrYlN+bNv61akIuzwoAj1kVv6xMfvnn2BPkxy5qhbnTxomj2EA?=
 =?us-ascii?Q?RI9sPJDPeV+AHk+5NH0HpVPfDdPyDnjQnIkbkIbES9Asl6nV8YaenuQPtIFa?=
 =?us-ascii?Q?er9yhIpotrl6R6zsz/xNo14wRttd5OAe53bqTwpI8VfD88vEM6hC0BGzIps/?=
 =?us-ascii?Q?6QzyJB5qj28YFye54VCn3LVuWwKs4KRpVNaXUW5YHw55joW4vKYewNoi0jIQ?=
 =?us-ascii?Q?Y0Jk8GQFAmJtCCKRkf0fQtpt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9b247b-69ad-4ad5-d17c-08d97ea1b0a2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 14:51:56.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tir9vcyVD6AkywakQfyASwZTC+vNGR+ePQx8VhiPxAlINkW7vSOYiiHrYrsnPjmAqIu674gFguSAfKbzTeTwWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3169
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:53:55PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Use a flag setting to call the only quirk function for that.
>

I'd like to add another quirk function. First revision here:
https://lkml.kernel.org/r/20210504174712.27675-2-Yazen.Ghannam@amd.com

Do you recommend this create another quirk flag and follow this patch? Or
should the quirks be grouped together somehow?

Thanks,
Yazen 
